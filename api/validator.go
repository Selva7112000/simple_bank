package api

import (
	"github.com/go-playground/validator/v10"
	"github.com/techschool/simplebank/db/util"
)

var validCurrency validator.Func = func(fieldLevel validator.FieldLevel) bool {
	if currrency, ok := fieldLevel.Field().Interface().(string); ok {
		return util.IsSupportedCurrency(currrency)
	}
	return false
}
