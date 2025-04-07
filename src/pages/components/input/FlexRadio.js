// ** React Imports
import { Fragment, useEffect, useState } from 'react'
import PropTypes from 'prop-types'

// ** MUI Imports

import FormLabel from '@mui/material/FormLabel'
import FormControlLabel from '@mui/material/FormControlLabel'
import Radio from '@mui/material/Radio'
import RadioGroup from '@mui/material/RadioGroup'

import FormControl from '@mui/material/FormControl'

import axios from 'axios'

const FlexRadio = props => {
  const url = props.url
  const params = props.params
  const label = props.label

  const config = {
    headers: {
      'content-type': 'application/json',
      Accept: 'application/json'
    }
  }

  // ** States

  const [dropdownValue, setdropdownValue] = useState([{ value: '' }])

  //** Handlers

  // ** Dieser Handler liftet den aktuellen Wert aus dem Select in höhere Komponente
  const onChangeHandler = e => {
    props.selectValue({ label, value: e.target.value })
  }

  //** HTTP REQUEST // Aktulle Dropdownwerte holen

  useEffect(() => {
    const http_request = axios({
      url: url,
      method: 'POST',
      data: JSON.stringify(params),
      headers: config.headers
    }).then(res => {
      setdropdownValue(res.data)
    })
  }, [props.selectValue])

  return (
    <Fragment>
      <FormControl
        sx={{ border: 1, borderColor: 'rgb(216,216,221)', borderRadius: '8px', padding: '5px, 0px, 0px, 0px ' }}
      >
        <FormLabel id='demo-row-radio-buttons-group-label'>{label}</FormLabel>
        <RadioGroup row aria-labelledby='demo-row-radio-buttons-group-label' defaultValue='' name={label}>
          {dropdownValue.map(element => (
            <FormControlLabel key={element.value} value={element.value} control={<Radio />} label={element.value} />
          ))}
        </RadioGroup>
      </FormControl>
    </Fragment>
  )
}

FlexRadio.prototype = {
  label: PropTypes.string,
  url: PropTypes.string,
  onChangeHandler: PropTypes.func
}

export default FlexRadio
