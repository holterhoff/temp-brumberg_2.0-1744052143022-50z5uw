import { createContext, useState } from 'react'

const DropdownContext = createContext({
  dropDownValues: [],
  addDropdownValues: dropDownValue => {}
})

export const DropdownContextProvider = props => {
  const [values, setValues] = useState([])

  const addDropdownValuesHandler = dropdownValue => {
    setValues(dropdownValue)

    //setValues(prevState => [prevState.filter(items => items.label !== dropdownValue.label), dropdownValue])

    // setValues(prevState => {
    //   return prevState.concat(dropdownValue)
    // })
  }

  const getDropdownValueHandler = value => {
    const found = values.find(element => element.label == value)

    return found.value
  }

  const context = {
    dropDownValues: values,
    addDropdownValues: addDropdownValuesHandler,
    getDropdownValues: getDropdownValueHandler
  }

  return <DropdownContext.Provider value={context}>{props.children}</DropdownContext.Provider>
}

export default DropdownContext
