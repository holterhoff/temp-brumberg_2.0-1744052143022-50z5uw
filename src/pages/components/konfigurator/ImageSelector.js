import React, { useState, useEffect } from 'react'

import FormLabel from '@mui/material/FormLabel'
import FormControlLabel from '@mui/material/FormControlLabel'
import Radio from '@mui/material/Radio'
import RadioGroup from '@mui/material/RadioGroup'
import { Fragment } from 'react'
import CardMedia from '@mui/material/CardMedia'
import Modal from '@mui/material/Modal'
import FormControl from '@mui/material/FormControl'
import Box from '@mui/material/Box'

import axios from 'axios'

const ImageSelector = props => {
  const url = props.url
  const params = props.params
  const label = props.label
  const imagePath = props.imagePath
  const defaultImage = props.defaultImage

  const config = {
    headers: {
      'content-type': 'application/json',
      Accept: 'application/json'
    }
  }

  const style = {
    position: 'absolute',
    top: '50%',
    left: '50%',
    transform: 'translate(-50%, -50%)',
    width: 400,
    bgcolor: 'background.paper',

    //border: '2px solid #000',
    boxShadow: 24,
    p: 4
  }

  //**STATES */

  const [image, setImage] = useState(defaultImage)
  const [open, setOpen] = useState(false)
  const handleOpen = () => setOpen(true)
  const handleClose = () => setOpen(false)

  //**HANDLERS */
  useEffect(() => {
    axios({
      url: url,
      method: 'POST',
      data: params,
      headers: config.headers
    }).then(res => {
      if (res.data.length > 0) {
        setImage(imagePath + res.data[0].value)
      } else {
        setImage(defaultImage)
      }
    })
  }, [params])

  return (
    <Fragment>
      <CardMedia onClick={handleOpen} component='img' image={image} alt={{ label }} sx={{ width: '60%' }} />

      <Modal open={open} onClose={handleClose}>
        <Box sx={style}>
          <CardMedia component='img' image={image} alt={{ label }} sx={{ width: '100%' }} />
        </Box>
      </Modal>
    </Fragment>
  )
}

export default ImageSelector
