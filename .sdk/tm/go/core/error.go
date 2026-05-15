package core

type FunisgoStreamingError struct {
	IsFunisgoStreamingError bool
	Sdk              string
	Code             string
	Msg              string
	Ctx              *Context
	Result           any
	Spec             any
}

func NewFunisgoStreamingError(code string, msg string, ctx *Context) *FunisgoStreamingError {
	return &FunisgoStreamingError{
		IsFunisgoStreamingError: true,
		Sdk:              "FunisgoStreaming",
		Code:             code,
		Msg:              msg,
		Ctx:              ctx,
	}
}

func (e *FunisgoStreamingError) Error() string {
	return e.Msg
}
