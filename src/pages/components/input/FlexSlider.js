// ** React Imports
import { Fragment, useEffect, useState, useContext } from 'react'
import WunschmassContext from 'src/context/wunschmassContext'
// ** MUI Imports
import Slider from '@mui/material/Slider'
import Typography from '@mui/material/Typography'

const FlexSlider = props => {
  // ** Props
  const url = props.url
  const params = props.params
  const label = props.label
  const step = props.step
  const icon = props.icon
  const min = props.min
  const max = props.max
  const konfigurator = props.konfigurator

  // ** States

  const [dropdownValue, setdropdownValue] = useState([])
  const [Value, setValue] = useState('')

  //** Context
  const wunschmassContext = useContext(WunschmassContext)
  //** Handlers

  const onChangeWunschmassHandler = e => {
    if (props.label === 'Wunschmaß A') {
      wunschmassContext.setValueA(e.target.value)
    }
    if (props.label === 'Wunschmaß B') {
      wunschmassContext.setValueB(e.target.value)
    }
    if (props.label === 'Wunschmaß C') {
      wunschmassContext.setValueC(e.target.value)
    }
  }
  const onChangeHandler = e => {
    setValue(e.target.value)
    props.selectValue({ konfigurator, label, value: e.target.value })
  }

  // ** Dieser Handler liftet den aktuellen Wert aus dem Select in höhere Komponente

  return (
    <div>
      <Typography sx={{ fontWeight: 500 }}>
        {label} : {Value}
      </Typography>
      <Slider
        defaultValue={min}
        min={min}
        max={max}
        step={step}
        aria-labelledby='continuous-slider'
        onChange={onChangeWunschmassHandler}
      />
    </div>
  )
}

export default FlexSlider
