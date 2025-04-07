'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getAnsteuerung(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // Grundabfrage
      let query = `
        SELECT DISTINCT ANSTEUERUNG as value_DE
        FROM biro40_Kep
        WHERE 1=1

      `

      // Dynamische Filter hinzufügen
      params.forEach(element => {
        if (element.label === 'FIGUR') {
          query += ` AND FIGUR = '${element.value}'`
        }
        if (element.label === 'MONTAGEART') {
          query += ` AND MONTAGEART = '${element.value}'`
        }
        if (element.label === 'GEHÄUSEFARBE') {
          query += ` AND GEHAEUSEFARBE = '${element.value}'`
        }
        if (element.label === 'LICHTFARBE') {
          query += ` AND LICHTFARBE = '${element.value}'`
        }
      })

      // Abfrage beenden
      query += ' ORDER BY 1'

      // Abfrage ausführen
      const result = await sql(query)

      // Antwort zurückgeben
      if (result) {
        res.status(200).json(result)
      } else {
        res.status(500).json({ message: 'Fehler beim Abrufen der Daten' })
      }
    } catch (error) {
      console.error('Error:', error)
      res.status(500).json({ message: 'Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
