'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getGehaeusefarbe(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // Grundabfrage
      let query = `
        SELECT DISTINCT GEHAEUSEFARBE as value_DE
        FROM biro40_Kep
        WHERE 1=1
        AND GEHAEUSEFARBE <> 'RAL NACH WAHL'
      `

      // Dynamische Filter aus params hinzufügen
      if (Array.isArray(params)) {
        params.forEach(element => {
          if (element.label === 'FIGUR') {
            query += ` AND FIGUR = '${element.value}'`
          }
          if (element.label === 'MONTAGEART') {
            query += ` AND MONTAGEART = '${element.value}'`
          }
        })
      }

      // Abfrage beenden
      query += ' ORDER BY 1'

      // Abfrage ausführen
      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Keine Ergebnisse gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen der Gehäusefarben:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
