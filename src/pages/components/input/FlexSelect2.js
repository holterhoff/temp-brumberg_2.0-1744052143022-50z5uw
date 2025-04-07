//TODO: We should improve this component. I would like to exchange the dropDownContext for 'Zustand' so that we can use a standardized store in the future.

// ** React Imports

import { Fragment, useEffect, useRef, useState } from 'react'
import PropTypes from 'prop-types'

// ** MUI Imports

import InputAdornment from '@mui/material/InputAdornment'
import FormControl from '@mui/material/FormControl'
import axios from 'axios'
import TextField from '@mui/material/TextField'
import Autocomplete from '@mui/material/Autocomplete'
import CircularProgress from '@mui/material/CircularProgress'
import Translations from 'src/layouts/components/Translations'
import { useTranslation } from 'react-i18next'

const FlexSelect2 = props => {
  const url = props.url
  const params = props.params
  const label = props.label
  const icon = props.icon
  const konfigurator = props.konfigurator

  const config = {
    headers: {
      'content-type': 'application/json',
      Accept: 'application/json'
    }
  }

  // ** States

  const [dropdownValue, setdropdownValue] = useState([])
  const [isLoading, setIsLoading] = useState(true)
  const [selectedValue, setSelectedValue] = useState('Bitte auswählen')
  const { t } = useTranslation()

  // ** Hooks
  const currentLanguage = localStorage.getItem('i18nextLng')

  //** Handlers

  // ** Dieser Handler liftet den aktuellen Wert aus dem Select in höhere Komponente
  const onChangeHandler = e => {
    setSelectedValue(e.target.outerText)
    props.selectValue({ konfigurator, label, value: e.target.outerText })
  }

  //** HTTP REQUEST // Aktulle Dropdownwerte holen

  useEffect(() => {
    const fetchData = async () => {
      setIsLoading(true)
      const response = await axios({
        url: url,
        method: 'POST',
        data: JSON.stringify(params),
        headers: config.headers
      })
      // when currentlanguage, iterate response.data and push the values into a variable and then set the state
      if (currentLanguage === 'de') {
        const languagevalues = []
        response.data.forEach(element => {
          languagevalues.push({ value: element.value_de })
        })
        setIsLoading(false)
        setdropdownValue(languagevalues)
      }
      if (currentLanguage === 'en') {
        const languagevalues = []
        response.data.forEach(element => {
          languagevalues.push({ value: element.value_en })
        })
        setIsLoading(false)
        setdropdownValue(languagevalues)
      }
    }
    fetchData()
  }, [props.selectValue, params, url])

  useEffect(() => {
    const hasValidValue = dropdownValue.some(elem => (elem.image ? elem.image : elem.value) === selectedValue)

    if (!hasValidValue) {
      setSelectedValue(t('Bitte auswählen'))
    }
  }, [dropdownValue, selectedValue])

  if (dropdownValue) {
    return (
      <Fragment>
        <FormControl fullWidth margin='dense'>
          <Autocomplete
            sx={{ borderRadius: 0, width: 'max' }}
            options={isLoading ? [] : dropdownValue}
            isOptionEqualToValue={(option, value) => option.value === value}
            value={selectedValue}
            loading={isLoading}
            onChange={onChangeHandler}
            renderInput={params => {
              return (
                <TextField
                  {...params}
                  label={<Translations text={label} />}
                  InputProps={{
                    ...params.InputProps,
                    startAdornment: (
                      <InputAdornment position='start'>
                        <Fragment>{icon}</Fragment>
                      </InputAdornment>
                    ),
                    endAdornment: (
                      <Fragment>
                        {isLoading ? <CircularProgress color='inherit' size={20} /> : null}
                        {params.InputProps.endAdornment}
                      </Fragment>
                    )
                  }}
                />
              )
            }}
            renderOption={(props, option) => {
              return (
                <li {...props}>
                  {option.image && (
                    <img
                      src={'/images/konfigurator/' + option.image}
                      alt={option.image}
                      style={{ width: '200px', marginRight: '10px' }}
                    />
                  )}
                  {option.image || option.value}
                </li>
              )
            }}
          />
        </FormControl>
      </Fragment>
    )
  } else null
}

FlexSelect2.prototype = {
  label: PropTypes.string,
  url: PropTypes.string,
  onChangeHandler: PropTypes.func
}

export default FlexSelect2
