const e = require('express')
const Scheme = require('./scheme-model')

/*
  If `scheme_id` does not exist in the database:

  status 404
  {
    "message": "scheme with scheme_id <actual id> not found"
  }
*/
const checkSchemeId = async (req, res, next) => {
    const { id } = req.params
    try {
        const scheme = await Scheme.findById(id)
        if (scheme) {
            req.scheme = scheme
            next()
        }
        else {
            res.status(400).json({ message: `scheme with scheme_id ${id} not found` })
        }
    }
    catch (err) {
        next(err)
    }
}

/*
  If `scheme_name` is missing, empty string or not a string:

  status 400
  {
    "message": "invalid scheme_name"
  }
*/
const validateScheme = (req, res, next) => {
    const name = req.body.scheme_name
    if (!name || typeof name !== 'string' || name.trim() == '') {
        res.status(400).json({ message: 'invalid scheme_name' })
    }
    else {
        next()
    }
}

/*
  If `instructions` is missing, empty string or not a string, or
  if `step_number` is not a number or is smaller than one:

  status 400
  {
    "message": "invalid step"
  }
*/
const validateStep = (req, res, next) => {
    const instr = req.body.instructions
    const num = req.body.step_number
    if (!instructions 
        || typeof instructions !== 'string' 
        || instructions.trim() == '' 
        || isNaN(num) 
        || typeof num !== 'number' 
        || num < 1 ) {
            res.status(400).json({ message: 'invalid step' })
    }
    else {
        next()
    }
}

module.exports = {
  checkSchemeId,
  validateScheme,
  validateStep,
}
