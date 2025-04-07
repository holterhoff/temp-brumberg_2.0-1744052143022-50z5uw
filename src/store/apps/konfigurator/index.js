import { createSlice, createAsyncThunk, current } from '@reduxjs/toolkit'

// ** Axios Imports
import axios from 'axios'

const DUMMY_DATA = { flex: [], m1: [] }

export const konfigurationSlice = createSlice({
  name: 'appKonfiguration',
  initialState: {
    data: DUMMY_DATA
  },
  reducers: {
    addKonfig(state, action) {
      state = state.data.flex.push(action.payload)
    },
    deleteKonfig(state, action) {
      const itemId = action.payload
      state.data.flex = state.data.flex.filter(v => v.id !== itemId)
    },
    resetKonfig(state, action) {
      state = state.data.flex = []
    },
    deletePosition(state, action) {
      const itemId = action.payload.konfigId // 01-00-1234567890
      const positionId = action.payload.row.id

      //Zeile löschen
      state.data.flex = state.data.flex.map(v => {
        if (v.id === itemId) {
          return {
            ...v,
            positions: v.positions.filter(pos => pos.id !== positionId)
          }
        }
        return v
      })

      //Prüfung, ob Positionen noch vorhanden sind
    }
  }

  // extraReducers: builder => {
  //   builder.addCase(fetchData.fulfilled, (state, action) => {
  //     state.data = action.payload.konfiguration
  //   })
  // }
})

export const konfiguratorActions = konfigurationSlice.actions

export default konfigurationSlice.reducer
