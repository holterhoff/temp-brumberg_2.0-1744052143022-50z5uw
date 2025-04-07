// TODO: We should improve this component. I would like to exchange the dropDownContext for 'Zustand' so that we can use a standardized store in the future.

import { Fragment, useEffect, useState } from 'react'
import PropTypes from 'prop-types'
import { Grid, MenuItem, Select, Typography } from '@mui/material'
import InputAdornment from '@mui/material/InputAdornment'
import FormControl from '@mui/material/FormControl'
import axios from 'axios'
import InputLabel from '@mui/material/InputLabel'
import useOptionsStore from 'src/store/apps/konfigurator/optionsStore'
import useMediaQuery from '@mui/material/useMediaQuery'

const FlexSelect2 = props => {
  const url = props.url
  const label = props.label
  const icon = props.icon

  const isDropDown = props.isDropDown

  // ** Der Key wird hier als lowercase verwendet, um eine konsistente Benennung zu gewährleisten
  const key = label.toLowerCase().replaceAll(' ', '')

  const config = {
    headers: {
      'content-type': 'application/json',
      Accept: 'application/json'
    }
  }

  // ** States
  const { options, setChoice, resetWunschmassOptions } = useOptionsStore()
  const [dropdownValue, setDropdownValue] = useState([])
  const [isLoading, setIsLoading] = useState(true)

  const isMobile = useMediaQuery('(max-width:600px)')

  // ** Produktdetails separat behandeln, wenn der Key 'produktbeschreibung' oder 'gesamtpreis' ist
  const selectedOption =
    key === 'produktbeschreibung' || key === 'gesamtpreis' ? options.produktdetails[key] : options[key]

  //** Handlers

  // ** Dieser Handler liftet den aktuellen Wert aus dem Select in höhere Komponente
  const handleSelect = item => {
    resetWunschmassOptions()
    setChoice(key, item.value_de)
  }

  //** HTTP REQUEST // Aktuelle Dropdownwerte holen
  useEffect(() => {
    let params = Object.keys(options).map(key => ({
      label: key.toUpperCase(),
      value: options[key]
    }))

    params = params.filter(item => item.value)

    const fetchData = async () => {
      setIsLoading(true)
      const response = await axios({
        url: url,
        method: 'POST',
        data: JSON.stringify(params),
        headers: config.headers
      })
      setIsLoading(false)
      setDropdownValue(response.data)
    }
    fetchData()
  }, [url, options])

  useEffect(() => {
    if (selectedOption) {
      const hasValidValue = dropdownValue.some(elem => (elem.image ? elem.image : elem.value_de) === selectedOption)

      if (!hasValidValue) {
        setChoice(key, null)
      }
    }
  }, [dropdownValue, selectedOption])

  if (dropdownValue) {
    return isDropDown ? (
      <Fragment>
        <FormControl fullWidth margin='dense'>
          <InputLabel id='form-layouts-separator-select-label'>{props.label}</InputLabel>
          <Select
            sx={{ borderRadius: 0 }}
            value={selectedOption || 'Bitte auswählen'}
            label={label}
            id='form-layouts-separator-select'
            labelId='form-layouts-separator-select-label'
            defaultValue={'none'}
            startAdornment={
              <InputAdornment position='start'>
                <Fragment>{icon}</Fragment>
              </InputAdornment>
            }
          >
            <MenuItem value='Bitte auswählen'>
              <em>Bitte auswählen</em>
            </MenuItem>
            {dropdownValue.map(item => (
              <MenuItem
                onClick={() => handleSelect(item)}
                key={item.value_de}
                value={item.value_de}
                style={{
                  display: 'flex',
                  flexDirection: 'row',
                  alignItems: 'center',
                  gap: '10px',
                  padding: '5px'
                }}
              >
                {item.value_de}
              </MenuItem>
            ))}
          </Select>
        </FormControl>
      </Fragment>
    ) : (
      <Grid
        container
        sx={{
          width: '100%'
        }}
      >
        {dropdownValue.slice(0).map((item, index) => {
          return (
            <Grid
              item
              xs={6}
              key={index + label}
              style={{
                display: 'flex',
                width: '100%',
                cursor: 'pointer',
                flexDirection: 'column',
                gap: '8px',
                padding: '8px',
                justifyContent: 'center',
                alignItems: 'center'
                // border: '2px solid red'
              }}
              onClick={() => handleSelect(item)}
            >
              <img
                src={'/images/icons/dropdown-icons/' + item.image + '.png' || '/images/noimage.png'}
                alt={item.value}
                style={{
                  width: isMobile ? '100%' : '100px',
                  height: isMobile ? '100%' : '100px',
                  border: selectedOption === item.value ? '0.5px solid red' : '0px solid black',
                  borderRadius: '5px',
                  padding: '2px'
                }}
              />
              <div style={{ display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center' }}>
                <Typography
                  sx={{
                    fontSize: '14px !important',
                    lineHeight: '.8',
                    fontWeight: selectedOption === item.value ? 'bold' : 'normal'
                  }}
                >
                  {item.value_de}
                </Typography>
              </div>
            </Grid>
          )
        })}
      </Grid>
    )
  } else return null
}

FlexSelect2.propTypes = {
  label: PropTypes.string,
  url: PropTypes.string,
  selectValue: PropTypes.func
}

export default FlexSelect2
