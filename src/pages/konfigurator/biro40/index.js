// ** React Imports
import { useState, useEffect } from 'react'

// ** MUI Imports
import Grid from '@mui/material/Grid'

import KonfiguratorHeader from 'src/pages/components/konfigurator/KonfiguratorHeader'
import Biro40Form from 'src/views/konfigurator/biro40/Biro40Form'
import { useAuth } from 'src/hooks/useAuth'
import useOptionsStore from '../../../store/apps/konfigurator/optionsStore'

const Biro40View = () => {
  const auth = useAuth()

  //**  States
  const { kep } = useOptionsStore()

  useEffect(() => {
    console.log(kep.headerbild)
  }, [kep])

  return (
    <Grid
      sx={{
        width: '100vw'
      }}
      container
      spacing={6}
    >
      <Grid item xs={12}>
        <KonfiguratorHeader
          modul={'Biro40'}
          subText={'Lichtkanalsystem'}
          profileImage={'/images/konfigurator/biro40/biro40_profile.jpg'}
          titleImage={
            kep.headerbild != ''
              ? '/images/konfigurator//biro40/produktbilder/' + kep.headerbild
              : '/images/konfigurator/biro40/produktbilder/I_ANBAU_W.jpg'
          }
        />
      </Grid>

      <Grid item xs={12} md={12} lg={12}>
        <Biro40Form />
      </Grid>
    </Grid>
  )
}

Biro40View.guestGuard = true

export default Biro40View
