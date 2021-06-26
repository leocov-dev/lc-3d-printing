package cli

import (
	"errors"
	"fmt"
	"strconv"
)

// custom cobra flag for concurrency value validation
type concurrencyValue int

var maxConcurrency int64 = 128

func NewConcurrencyValue(val int, p *int) *concurrencyValue {
	*p = val
	return (*concurrencyValue)(p)
}

func (i *concurrencyValue) Set(s string) error {
	v, err := strconv.ParseInt(s, 0, 64)
	if err != nil {
		return err
	}

	if v > maxConcurrency || v < 1 {
		return errors.New(fmt.Sprintf("value must be 1 - %d", maxConcurrency))
	}

	*i = concurrencyValue(v)
	return nil
}

func (i *concurrencyValue) Type() string {
	return "int"
}

func (i *concurrencyValue) String() string { return strconv.FormatInt(int64(*i), 10) }
