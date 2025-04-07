import { createContext, useState } from 'react'

const WunschmassContext = createContext({
  wunschmass_a: 1000,
  wunschmass_b: 1000,
  wunschmass_c: 1000
})

export const WunschmassContextProvider = props => {
  const [valueA, setValueA] = useState()
  const [valueB, setValueB] = useState()
  const [valueC, setValueC] = useState()


  const setWunschmass_a = a => {
    setWunschmass_a(a)
  }

  const setWunschmass_b = b => {
    setWunschmass_b(b)
  }
  const setWunschmass_c = c => {
    setWunschmass_c(c)
  }

  const context = {
    wunschmass_a: valueA,
    wunschmass_b: valueB,
    wunschmass_c: valueC,
    setValueA: setValueA,
    setValueB: setValueB,
    setValueC: setValueC
  }

  return <WunschmassContext.Provider value={context}>{props.children}</WunschmassContext.Provider>
}

export default WunschmassContext
