// ** React Imports
import { Fragment, useEffect, useState } from 'react'
import PropTypes from 'prop-types'

// ** MUI Imports
import CardMedia from '@mui/material/CardMedia'
import Box from '@mui/material/Box'
import List from '@mui/material/List'
import ListItemButton from '@mui/material/ListItemButton'
import ListItem from '@mui/material/ListItem'
import ListItemIcon from '@mui/material/ListItemIcon'
import ListItemText from '@mui/material/ListItemText'

import axios from 'axios'

const FlexSelectList = props => {
  const url = props.url
  const params = props.params
  const label = props.label
  const konfigurator = props.konfigurator

  const config = {
    headers: {
      'content-type': 'application/json',
      Accept: 'application/json'
    }
  }
  // ** States

  const [dropdownValue, setdropdownValue] = useState([{ value: '' }])
  const [selectedIndex, setSelectedIndex] = useState()
  //** Handlers

  // ** Dieser Handler liftet den aktuellen Wert aus dem Select in höhere Komponente
  const onChangeHandler = (e, index) => {
    setSelectedIndex(index)
    console.log(e.target.textContent)
    props.selectValue({ label, value: e.target.textContent })
  }

  //** HTTP REQUEST // Aktulle Dropdownwerte holen
  useEffect(
    () => {
      axios({
        url: url,
        method: 'POST',
        data: JSON.stringify(params),
        headers: config.headers
      }).then(res => {
        setdropdownValue(res.data)
      })
    },
    [props.selectValue],
    params,
    url
  )

  if (dropdownValue) {
    return (
      <Fragment>
        <List component='nav' aria-label='main mailbox folders'>
          {dropdownValue.map((element, index) => (
            <ListItemButton
              key={element.value}
              selected={selectedIndex === index}
              // selected={true}
              onClick={event => onChangeHandler(event, index)}
            >
              <Box sx={{ display: 'flex', alignItems: 'center' }}>
                <CardMedia
                  sx={{ height: 100 }}
                  component='img'
                  image='https://www.brumberg.com/fileadmin/mediafiles/_processed_/a/9/csm_header_flex_sets_4be2751e26.jpg'
                  title='green iguana'
                />
                <ListItemText primary={element.value} />
              </Box>
            </ListItemButton>
          ))}
        </List>
      </Fragment>
    )
  }
}

FlexSelectList.prototype = {
  label: PropTypes.string,
  url: PropTypes.string,
  onChangeHandler: PropTypes.func
}

export default FlexSelectList
