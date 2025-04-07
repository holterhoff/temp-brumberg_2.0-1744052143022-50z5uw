import { createContext, useState } from 'react'

const ModelContext = createContext({
  modelValues: [],
  addModelValues: modelValues => {}
})

export const ModelContextProvider = props => {
  const [values, setValues] = useState([])

  const addModelValuesHandler = modelValues => {
    setValues(modelValues)
  }

  const context = {
    modelValues: values,
    addModelValues: addModelValuesHandler
  }

  return <ModelContext.Provider value={context}>{props.children}</ModelContext.Provider>
}

export default ModelContext
