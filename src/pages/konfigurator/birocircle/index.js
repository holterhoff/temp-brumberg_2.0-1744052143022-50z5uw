// ** MUI Imports
import Grid from '@mui/material/Grid'

import BirocircleHeader from 'src/views/konfigurator/birocircle/BirocircleHeader'
import BirocircleTable from 'src/views/konfigurator/birocircle/BirocircleTable'
import BirocircleForm from 'src/views/konfigurator/birocircle/BirocircleForm'

import { useAuth } from 'src/hooks/useAuth'

const BirocircleyView = ({ tab, invoiceData }) => {
  const auth = useAuth()

  return (
    <Grid container spacing={6}>
      <Grid item xs={12}>
        <BirocircleHeader />
      </Grid>

      <Grid item xs={12} md={12} lg={12}>
        <BirocircleForm />
      </Grid>
      <Grid item xs={12} md={12} lg={12}>
        <BirocircleTable />
      </Grid>
    </Grid>
  )
}

BirocircleyView.guestGuard = true

export default BirocircleyView
