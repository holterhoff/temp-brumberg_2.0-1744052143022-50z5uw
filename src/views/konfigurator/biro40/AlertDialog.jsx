import * as React from 'react'
import { useEffect } from 'react'
import Button from '@mui/material/Button'
import Dialog from '@mui/material/Dialog'
import DialogActions from '@mui/material/DialogActions'
import DialogContent from '@mui/material/DialogContent'
import DialogContentText from '@mui/material/DialogContentText'
import DialogTitle from '@mui/material/DialogTitle'
import Slide from '@mui/material/Slide'
import Alert from '@mui/material/Alert'
import Stack from '@mui/material/Stack'

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction='down' ref={ref} {...props} />
})

export default function AlertDialogSlide(props) {
  const [open, setOpen] = React.useState(props.open)

  const handleClickOpen = () => {
    setOpen(true)
  }

  const handleClose = () => {
    setOpen(false)
    props.setOpen(false)
  }

  useEffect(() => {
    setOpen(props.open)
  }, [props.open])

  return (
    <React.Fragment>
      <Dialog
        open={open}
        TransitionComponent={Transition}
        keepMounted
        onClose={handleClose}
        aria-describedby='alert-dialog-slide-description'
      >
        {/* <DialogTitle>{"Use Google's location service?"}</DialogTitle> */}
        <Stack sx={{ width: '100%' }} spacing={2}>
          <Alert variant='filled' severity='error'>
            Die Suche war nicht erfolgreich. Bitte versuchen Sie es erneut.
          </Alert>
        </Stack>
        <DialogActions>
          <Button onClick={handleClose}>OK</Button>
        </DialogActions>
      </Dialog>
    </React.Fragment>
  )
}
