// ** Next Import
import Link from 'next/link'

// ** MUI Imports
import IconButton from '@mui/material/IconButton'
import Box from '@mui/material/Box'
import { styled, useTheme } from '@mui/material/styles'
import Typography from '@mui/material/Typography'

// ** Custom Icon Import
import Icon from 'src/@core/components/icon'

// ** Configs
import themeConfig from 'src/configs/themeConfig'

// ** Styled Components
const MenuHeaderWrapper = styled(Box)(({ theme }) => ({
  display: 'flex',
  alignItems: 'center',
  paddingRight: theme.spacing(4),
  justifyContent: 'space-between',
  transition: 'padding .25s ease-in-out',
  minHeight: theme.mixins.toolbar.minHeight
}))

const HeaderTitle = styled(Typography)({
  fontWeight: 700,
  lineHeight: 1.2,
  transition: 'opacity .25s ease-in-out, margin .25s ease-in-out'
})

const LinkStyled = styled(Link)({
  display: 'flex',
  alignItems: 'center',
  textDecoration: 'none'
})

const VerticalNavHeader = props => {
  // ** Props
  const {
    hidden,
    navHover,
    settings,
    saveSettings,
    collapsedNavWidth,
    toggleNavVisibility,
    navigationBorderWidth,
    menuLockedIcon: userMenuLockedIcon,
    navMenuBranding: userNavMenuBranding,
    menuUnlockedIcon: userMenuUnlockedIcon
  } = props

  // ** Hooks & Vars
  const theme = useTheme()
  const { mode, direction, navCollapsed } = settings
  const menuCollapsedStyles = navCollapsed && !navHover ? { opacity: 0 } : { opacity: 1 }

  const svgFillSecondary = () => {
    if (mode === 'semi-dark') {
      return `rgba(${theme.palette.customColors.dark}, 0.6)`
    } else {
      return theme.palette.text.secondary
    }
  }

  const svgFillDisabled = () => {
    if (mode === 'semi-dark') {
      return `rgba(${theme.palette.customColors.dark}, 0.38)`
    } else {
      return theme.palette.text.disabled
    }
  }

  const menuHeaderPaddingLeft = () => {
    if (navCollapsed && !navHover) {
      if (userNavMenuBranding) {
        return 0
      } else {
        return (collapsedNavWidth - navigationBorderWidth - 40) / 8
      }
    } else {
      return 5.5
    }
  }

  const svgRotationDeg = () => {
    if (navCollapsed) {
      if (direction === 'rtl') {
        if (navHover) {
          return 0
        } else {
          return 180
        }
      } else {
        if (navHover) {
          return 180
        } else {
          return 0
        }
      }
    } else {
      if (direction === 'rtl') {
        return 180
      } else {
        return 0
      }
    }
  }

  return (
    <MenuHeaderWrapper className='nav-header' sx={{ pl: menuHeaderPaddingLeft() }}>
      {userNavMenuBranding ? (
        userNavMenuBranding(props)
      ) : (
        <LinkStyled href='/'>
          {/* Brumberg Logo */}
          <svg height={60} width={100} viewBox='0 -90 100 200' xmlns='http://www.w3.org/2000/svg'>
            <g transform='translate(-147 -38)'>
              <path
                d='M152.2,42.8v6.7h2.2c4,0,5.4-0.9,5.4-3.4c0-2.6-1.3-3.3-5.7-3.3H152.2 M152.2,53.7v7.9h2.3c5.3,0,6.6-0.8,6.6-3.9
		c0-3.1-1.5-4-6.5-4L152.2,53.7 M153.5,65.8H147V38.5h7.3c3.2,0,4.9,0.2,6.3,0.7c2.6,0.9,4.4,3.4,4.3,6.2c0,3-1.3,4.8-4.4,5.8
		c4,0.9,5.9,3.2,5.9,6.8c0.1,3.2-2,6.1-5,7.2C159.4,65.7,158.3,65.8,153.5,65.8'
              />
              <path
                d='M176.2,43v7.9h1.9c5.1,0,6.8-1,6.8-4c0-1.3-0.6-2.5-1.8-3.2c-1.1-0.6-1.9-0.7-5.4-0.7L176.2,43 M191.6,65.8h-6.1L180,55.4
		h-3.8v10.4h-5.2V38.5h6.8c4.8,0,6.7,0.3,8.5,1.3c2.5,1.5,4,4.2,3.9,7.1c0.2,3.3-1.8,6.3-4.8,7.6L191.6,65.8'
              />
              <path
                d='M205.5,66.3c-4.6,0-8.1-1.8-9.7-5.1c-0.9-1.7-1.1-3-1.1-7V38.5h5.3v15.7c0,3.3,0.1,4.3,0.9,5.5c1.1,1.5,2.8,2.3,4.6,2.1
		c3.2,0,5.2-1.7,5.4-4.7c0.1-1,0.1-2,0.1-3V38.5h5.2v15.7c0,4-0.2,5.3-1.1,7C213.7,64.5,210,66.3,205.5,66.3'
              />
              <path d='M248.5,65.8h-4.7V44.5L238,65.8h-5.4l-5.7-21.3v21.3h-4.7V38.5h7.3l5.9,21.7l5.9-21.7h7.2V65.8z' />
              <path
                d='M259.9,42.8v6.7h2.2c4,0,5.4-0.9,5.4-3.4c0-2.6-1.3-3.3-5.7-3.3H259.9 M259.9,53.7v7.9h2.3c5.3,0,6.6-0.8,6.6-3.9
		c0-3.1-1.5-4-6.5-4L259.9,53.7 M261.2,65.8h-6.5V38.5h7.3c3.2,0,4.9,0.2,6.3,0.7c2.6,0.9,4.4,3.4,4.3,6.2c0,3-1.3,4.8-4.4,5.8
		c4,0.9,5.9,3.2,5.9,6.8c0.1,3.2-2,6.1-5,7.2C267.2,65.7,266,65.8,261.2,65.8'
              />
              <path d='M296.4,65.8h-17.6V38.5h17.1V43H284v6.4h10.8v4.4H284v7.4h12.4V65.8z' />
              <path
                d='M306.8,43v7.9h1.9c5.1,0,6.7-1,6.7-4c0-1.3-0.6-2.5-1.8-3.2c-1.1-0.6-1.9-0.7-5.4-0.7L306.8,43 M322.2,65.8h-6.1l-5.6-10.4
		h-3.8v10.4h-5.2V38.5h6.8c4.8,0,6.7,0.3,8.5,1.3c2.5,1.5,4,4.2,3.9,7.1c0.2,3.3-1.8,6.3-4.8,7.6L322.2,65.8'
              />
              <path
                d='M337,66.3c-7.7,0-12.6-5.4-12.6-14.1c0-8.6,4.8-14.3,12.2-14.3c6,0,9.7,3.5,10,9.3h-4.5c-0.5-3.2-2.2-4.8-5.4-4.8
		c-4.3,0-6.8,3.6-6.8,9.7s2.6,9.6,7.1,9.6c2,0,4-0.7,5.7-1.8v-4.4h-5.5v-3.9h9.7v11.3C344.1,65.2,340.6,66.4,337,66.3'
              />
            </g>
          </svg>
          <HeaderTitle variant='h6' sx={{ ...menuCollapsedStyles, ...(navCollapsed && !navHover ? {} : { ml: 2 }) }}>
            {themeConfig.templateName}
          </HeaderTitle>
        </LinkStyled>
      )}

      {hidden ? (
        <IconButton
          disableRipple
          disableFocusRipple
          onClick={toggleNavVisibility}
          sx={{ p: 0, backgroundColor: 'transparent !important' }}
        >
          <Icon icon='mdi:close' fontSize={20} />
        </IconButton>
      ) : userMenuLockedIcon === null && userMenuUnlockedIcon === null ? null : (
        <IconButton
          disableRipple
          disableFocusRipple
          onClick={() => saveSettings({ ...settings, navCollapsed: !navCollapsed })}
          sx={{ p: 0, color: 'text.primary', backgroundColor: 'transparent !important' }}
        >
          {userMenuLockedIcon && userMenuUnlockedIcon ? (
            navCollapsed ? (
              userMenuUnlockedIcon
            ) : (
              userMenuLockedIcon
            )
          ) : (
            <Box
              width={22}
              fill='none'
              height={22}
              component='svg'
              viewBox='0 0 22 22'
              xmlns='http://www.w3.org/2000/svg'
              sx={{
                transform: `rotate(${svgRotationDeg()}deg)`,
                transition: 'transform .25s ease-in-out .35s'
              }}
            >
              <path
                fill={svgFillSecondary()}
                d='M11.4854 4.88844C11.0082 4.41121 10.2344 4.41121 9.75716 4.88844L4.51029 10.1353C4.03299 10.6126 4.03299 11.3865 4.51029 11.8638L9.75716 17.1107C10.2344 17.5879 11.0082 17.5879 11.4854 17.1107C11.9626 16.6334 11.9626 15.8597 11.4854 15.3824L7.96674 11.8638C7.48943 11.3865 7.48943 10.6126 7.96674 10.1353L11.4854 6.61667C11.9626 6.13943 11.9626 5.36568 11.4854 4.88844Z'
              />
              <path
                fill={svgFillDisabled()}
                d='M15.8683 4.88844L10.6214 10.1353C10.1441 10.6126 10.1441 11.3865 10.6214 11.8638L15.8683 17.1107C16.3455 17.5879 17.1193 17.5879 17.5965 17.1107C18.0737 16.6334 18.0737 15.8597 17.5965 15.3824L14.0779 11.8638C13.6005 11.3865 13.6005 10.6126 14.0779 10.1353L17.5965 6.61667C18.0737 6.13943 18.0737 5.36568 17.5965 4.88844C17.1193 4.41121 16.3455 4.41121 15.8683 4.88844Z'
              />
            </Box>
          )}
        </IconButton>
      )}
    </MenuHeaderWrapper>
  )
}

export default VerticalNavHeader
