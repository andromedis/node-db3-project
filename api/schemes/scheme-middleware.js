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
    const { scheme_id } = req.params
    try {
        const scheme = await Scheme.findById(scheme_id)
        if (scheme) {
            next()
        }
        else {
            res.status(404).json({ message: `scheme with scheme_id ${scheme_id} not found` })
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
    const { scheme_name } = req.body
    const failed = !scheme_name 
                    || typeof scheme_name !== 'string' 
                    || scheme_name.trim() == ''
    
    if (failed) {
        res.status(400).json({ message: 'invalid scheme_name' })
    }
    else {
        req.body = { scheme_name: scheme_name.trim() } 
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
    const { instructions, step_number } = req.body
    const failed = !instructions 
                    || typeof instructions !== 'string' 
                    || instructions.trim() == '' 
                    || isNaN(step_number) 
                    || typeof step_number !== 'number' 
                    || step_number < 1 
    if (failed) {
        res.status(400).json({ message: 'invalid step' })
    }
    else {
        req.body = { instructions: instructions.trim(), step_number }
        next()
    }
}

module.exports = {
  checkSchemeId,
  validateScheme,
  validateStep,
}
