// ** MUI Imports
import Grid from '@mui/material/Grid'

import KonfiguratorHeader from 'src/pages/components/konfigurator/KonfiguratorHeader'
import SpotForm from 'src/views/konfigurator/spot/SpotForm'
import { useAuth } from 'src/hooks/useAuth'
import { useState } from 'react'

const SpotView = ({ tab, invoiceData }) => {
  const auth = useAuth()

  return (
    <Grid container spacing={6}>
      <Grid item xs={12}>
        <KonfiguratorHeader
          modul={'Spot'}
          subText={'In drei Schritten zur individuellen Leuchte.'}
          profileImage={'/images/konfigurator/0063.25.jpg'}
          titleImage={'https://www.brumberg.com/fileadmin/mediafiles/_processed_/e/5/csm_M1_Head_c2619694f3.jpg'}
        />
      </Grid>

      <Grid item xs={12} md={12} lg={12}>
        <SpotForm />
      </Grid>
    </Grid>
  )
}

SpotView.guestGuard = true

export default SpotView
