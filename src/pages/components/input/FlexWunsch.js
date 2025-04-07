import { Fragment, useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import { FormControl, InputAdornment, TextField, Autocomplete, useMediaQuery } from '@mui/material'
import axios from 'axios'
import useOptionsStore from 'src/store/apps/konfigurator/optionsStore'

const FlexWunsch = props => {
  const url = props.url
  const label = props.label
  const icon = props.icon
  const konfigurator = props.konfigurator
  const inputdisabled = props.disabled

  const config = {
    headers: {
      'content-type': 'application/json',
      Accept: 'application/json'
    }
  }

  // ** States
  const [dropdownValue, setDropdownValue] = useState([])
  const [isLoading, setIsLoading] = useState(true)

  const isMobile = useMediaQuery('(max-width:600px)')
  const { wunschmassOptions, getWunschmassOptions, setWunschmassChoice } = useOptionsStore()

  // Ensure key consistency
  const key = label.toLowerCase().replaceAll(' ', '')
  const selectedOption = wunschmassOptions[key] || ''

  // Handle selection
  const handleSelect = (event, newValue) => {
    if (newValue) {
      setWunschmassChoice(key, newValue.value_de)
    } else {
      setWunschmassChoice(key, null)
    }
  }

  // Fetch dropdown options
  useEffect(() => {
    const fetchData = async () => {
      setIsLoading(true)
      try {
        const response = await axios({
          url: url,
          method: 'POST',
          data: JSON.stringify({ schenkel: props.schenkel, basismass: props.basismass }),
          headers: config.headers
        })

        setDropdownValue(response.data)
      } catch (error) {
        console.error('Error fetching data:', error)
      }
      setIsLoading(false)
    }
    fetchData()
  }, [props.basismass, props.schenkel])

  // // Validate selected option
  // useEffect(() => {
  //   if (selectedOption) {
  //     console.log(dropdownValue)
  //     const hasValidValue = dropdownValue.some(elem => {
  //       if (elem.image) {
  //         return elem.image === selectedOption
  //       }
  //       return elem.value_de === selectedOption
  //     })

  //     if (!hasValidValue) {
  //       setWunschmassChoice(key, null)
  //     }
  //   }
  // }, [dropdownValue, selectedOption])

  // Function to filter dropdown options
  const handleFilterOptions = (options, { inputValue }) => {
    if (!inputValue) return options

    const inputNumber = parseFloat(inputValue)
    if (isNaN(inputNumber)) return options

    // Sortiere Optionen numerisch
    const sortedOptions = [...options].sort((a, b) => a.value_de - b.value_de)

    let smaller = null,
      exact = null,
      larger = null

    // Iteriere über die sortierten Optionen
    for (let i = 0; i < sortedOptions.length; i++) {
      const current = sortedOptions[i]
      if (current.value_de < inputNumber) {
        smaller = current
      } else if (current.value_de === inputNumber) {
        exact = current
      } else if (current.value_de > inputNumber && !larger) {
        larger = current
        break
      }
    }

    // Rückgabe: falls vorhanden, wird zuerst die nächstkleinere, dann der exakte und dann die nächstgrößere Option zurückgegeben.
    const result = []
    if (smaller) result.push(smaller)
    if (exact) result.push(exact)
    if (larger) result.push(larger)
    return result
  }

  return (
    <Fragment>
      <FormControl fullWidth margin='dense'>
        <Autocomplete
          options={dropdownValue}
          getOptionLabel={option => String(option.value_de)}
          value={dropdownValue.find(item => item.value_de === selectedOption) || null}
          onChange={handleSelect}
          isOptionEqualToValue={(option, value) => option.value_de === value?.value_de}
          filterOptions={handleFilterOptions}
          renderInput={params => (
            <TextField
              {...params}
              label={label}
              InputProps={{
                ...params.InputProps,
                startAdornment: (
                  <InputAdornment position='start'>
                    <Fragment>{icon}</Fragment>
                  </InputAdornment>
                )
              }}
            />
          )}
        />
      </FormControl>
    </Fragment>
  )
}

FlexWunsch.propTypes = {
  label: PropTypes.string,
  url: PropTypes.string,
  selectValue: PropTypes.func
}

export default FlexWunsch
