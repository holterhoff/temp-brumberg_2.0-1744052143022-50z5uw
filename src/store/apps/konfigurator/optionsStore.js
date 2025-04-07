import { create } from 'zustand'

const useOptionsStore = create((set, get) => ({
  options: {
    montageart: '',
    gehäusefarbe: '',
    lichtfarbe: '',
    cri: '',
    lichtstrom: '',
    ansteuerung: '',
    optischessystem: '',
    systemlänge: '',
    lv_position: 'LV Position'
  },
  kep: {}, // ALLE KEP Daten
  wunschmassOptions: {},
  output: {},
  biro_konfiguration: {},

  setBiroKonfiguration: value => {
    set({ biro_konfiguration: value })
  },
  getBiroKonfiguration: () => {
    get().biro_konfiguration
  },
  // ─────────────────────────────────────────────────────────
  // WICHTIG: Hier die Funktion zum Löschen eines Eintrags
  // ─────────────────────────────────────────────────────────
  deleteBiroKonfiguration: id => {
    set(state => {
      const newBiro = { ...state.biro_konfiguration }
      const keyToDelete = id // Erstelle den Key-Namen dynamisch
      if (newBiro[keyToDelete]) {
        delete newBiro[keyToDelete]
      }
      return { biro_konfiguration: newBiro }
    })
  },

  // ─────────────────────────────────────────────────────────

  resetOutput: () => {
    set({ output: {} })
  },

  setKep: value => {
    set({ kep: value })
  },

  getKep: key => get().kep[key],

  setOutput: value => {
    set({ output: value })
  },
  getOutput: key => get().output[key],

  resetWunschmassOptions: () => {
    set({ wunschmassOptions: {} })
  },

  setWunschmassChoice: (key, value, source) => {
    console.log('values that we are getting', key, value, source)
    set({ wunschmassOptions: { ...get().wunschmassOptions, [key]: value } })
  },

  getWunschmassOptions: key => get().wunschmassOptions[key],

  // Set a choice based on a key-value pair
  setChoice: (key, value) => {
    if (key === 'produktbeschreibung' || key === 'gesamtpreis') {
      set({
        options: {
          ...get().options,
          produktdetails: {
            ...get().options.produktdetails,
            [key]: value
          }
        }
      })
    } else {
      set({ options: { ...get().options, [key]: value } })
    }
  },

  // Get the value of a specific choice by key
  getChoice: key => {
    if (key === 'produktbeschreibung' || key === 'gesamtpreis') {
      return get().options.produktdetails[key]
    }
    return get().options[key]
  },

  // Get all choices as an object
  getAllChoices: () => get().options,

  // Reset all options to their default values
  resetChoices: () => {
    set({
      options: {
        basismass: null,
        figur: '',
        montageart: '',
        gehäusefarbe: '',
        lichtfarbe: '',
        cri: '',
        lichtstrom: '',
        ansteuerung: '',
        optischessystem: '',
        systemlänge: '',
        produktdetails: {
          konfigurationsID: '',
          produktbeschreibung: '',
          gesamtpreis: ''
        }
      }
    })
  }
}))

export default useOptionsStore
