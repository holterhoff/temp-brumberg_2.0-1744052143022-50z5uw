import React, { useEffect, useState } from 'react'

const LdtGenerator = () => {
  const [restOfFile, setRestOfFile] = useState('')

  // Beispiel: Dynamik in den ersten 30 Zeilen durch State, Props oder Berechnungen
  const getDynamicLines = () => {
    const lines = []
    for (let i = 1; i <= 30; i++) {
      lines.push(`Dynamische Zeile ${i}`)
    }
    return lines.join('\n')
  }

  useEffect(() => {
    // Beispiel: Restliche Zeilen aus einer Datei laden (im public-Ordner abgelegt)
    // Stelle sicher, dass "statischerTeil.ldt" oder .txt im public-Ordner liegt
    fetch('/statischerTeil.ldt')
      .then(res => res.text())
      .then(data => {
        setRestOfFile(data)
      })
      .catch(err => {
        console.error('Fehler beim Laden der statischen LDT-Datei:', err)
      })
  }, [])

  const handleDownload = () => {
    const dynamicText = getDynamicLines()
    const completeFile = dynamicText + '\n' + restOfFile

    // Blob erzeugen mit dem zusammengefügten Inhalt
    const blob = new Blob([completeFile], { type: 'text/plain' })
    const url = URL.createObjectURL(blob)

    // Virtuellen Link erzeugen und Download anstoßen
    const link = document.createElement('a')
    link.href = url
    link.download = 'ergebnis.ldt' // Name der Download-Datei
    link.click()

    // Speicher wieder freigeben
    URL.revokeObjectURL(url)
  }

  return (
    <div>
      <button onClick={handleDownload}>LDT-Datei herunterladen</button>
    </div>
  )
}

export default LdtGenerator
