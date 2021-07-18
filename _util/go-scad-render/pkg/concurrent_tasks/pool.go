// Package concurrent_tasks
//
// Inspired by:
//   Giuseppe Malavolta
//   https://medium.com/@zufolo/a-pattern-for-limiting-the-number-of-goroutines-in-execution-56e13b226e72
//
package concurrent_tasks

import (
	"sync"
)

type Pool struct {
	maxWorkers    int
	queue         chan *Proc
	wg            sync.WaitGroup
	Errors        chan string
	cancelOnError bool
}

func NewPool(concurrencyLimit int, cancelOnError bool) *Pool {
	dpl := &Pool{
		maxWorkers:    concurrencyLimit,
		queue:         make(chan *Proc),
		wg:            sync.WaitGroup{},
		Errors:        make(chan string, 512),
		cancelOnError: cancelOnError,
	}
	dpl.init()

	return dpl
}

func (dpl *Pool) init() {
	for worker := 0; worker < dpl.maxWorkers; worker++ {
		dpl.wg.Add(1)

		go func(worker int) {
			defer dpl.wg.Done()

			for proc := range dpl.queue {
				err := proc.Execute()
				if err != nil {
					dpl.Errors <- err.Error()
				}
			}
		}(worker)
	}
}

func (dpl *Pool) Add(proc *Proc) {
	dpl.queue <- proc
}

func (dpl *Pool) Process() []string {
	close(dpl.queue)
	dpl.wg.Wait()
	close(dpl.Errors)

	var poop []string
	for i := range dpl.Errors {
		poop = append(poop, i)
	}

	return poop
}
