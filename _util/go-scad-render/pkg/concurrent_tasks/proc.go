package concurrent_tasks

import (
	"context"
)

type Proc struct {
	ctx          context.Context
	cancel       context.CancelFunc
	afterExecute func()
	exec         func() error
	onError      func(err error)
}

func NewProc(
	execFunc func() error,
	afterFunc func(),
	errorFunc func(err error),
	context context.Context,
	cancel context.CancelFunc,
) *Proc {

	proc := &Proc{
		ctx:          context,
		cancel:       cancel,
		exec:         execFunc,
		afterExecute: afterFunc,
		onError:      errorFunc,
	}

	return proc
}

func (proc *Proc) Execute() error {
	if proc.afterExecute != nil {
		defer proc.afterExecute()
	}

	select {
	case <-proc.ctx.Done():
		ctxErr := proc.ctx.Err()
		if proc.onError != nil {
			proc.onError(ctxErr)
		}
		return nil
	default:
		err := proc.exec()
		if proc.onError != nil {
			proc.onError(err)
		}
		return err
	}
}
