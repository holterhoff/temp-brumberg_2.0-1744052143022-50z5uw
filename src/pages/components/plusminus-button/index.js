// ** React Imports

import { Fragment, useEffect, useState } from 'react'

// ** MUI Imports
import { FormControl, Grid, IconButton, TextField } from '@mui/material'
import Translations from 'src/layouts/components/Translations'
// ** Icon Imports
import Icon from 'src/@core/components/icon'

const Plus_Minus_Button = props => {
  //** State

  const max = parseInt(props.max)
  const min = parseInt(props.min)
  const step = parseInt(props.step)
  const label = props.label
  const konfigurator = props.konfigurator
  const [value, setValue] = useState(parseInt(props.defaultValue))

  //** Handlers

  const onIncrementHandler = () => {
    if (!max) {
      setValue(value + step)
    }

    if (max && value < max) {
      setValue(value + step)
    }

    if (max && value > max) {
      setValue(max)
    }
  }

  const onDecrementHandler = () => {
    // if (!min) {
    //   setValue(value - step)
    // }

    if (value > min + 1) {
      setValue(value - step)
    }
    if (min && value < min) {
      setValue(min)
    }
  }

  useEffect(
    function () {
      props.selectValue({ konfigurator, label, value: value })
    },
    [value]
  )

  const onManuelHandler = e => {
    setValue(parseInt(e.target.value))
  }

  return (
    <Fragment>
      <FormControl fullWidth margin='dense'>
        <Grid container item sx={{ border: 1, borderColor: 'rgb(216,216,221)', borderRadius: '8px' }}>
          <Grid item xs={2} display='flex' justifyContent='flex-start' alignItems='center'>
            <IconButton onClick={onDecrementHandler} sx={{ color: 'black' }} aria-label='Plus'>
              <Icon icon='ic:baseline-remove-circle' />
              {/* <RemoveCircleSharpIcon sx={{fontSize:40}} ></RemoveCircleSharpIcon> */}
            </IconButton>
          </Grid>
          <Grid item xs={8} display='flex' justifyContent='center' alignItems='center'>
            <TextField
              onChangeCapture={onManuelHandler}
              value={value}
              label={<Translations text={label} />}
              fullWidth
              sx={{ textAlignLast: 'center', textAlign: 'center' }}
              variant='filled'
            />
          </Grid>

          <Grid item xs={2} display='flex' justifyContent='flex-end' alignItems='center'>
            <IconButton onClick={onIncrementHandler} sx={{ color: 'black' }} aria-label='Plus'>
              <Icon icon='material-symbols:add-circle' />
              {/* <AddCircleSharpIcon  sx={{fontSize:40 }}  ></AddCircleSharpIcon> */}
            </IconButton>
          </Grid>
        </Grid>
      </FormControl>
    </Fragment>
  )
}

export default Plus_Minus_Button
