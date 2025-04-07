'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getFigur(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // Grundabfrage
      let query = `
        SELECT DISTINCT figur_pos, figur as value_de
        FROM biro40_kep
        WHERE 1=1

      `

      // // Dynamische Filter aus params hinzufügen
      // if (Array.isArray(params)) {
      //   params.forEach(element => {
      //     if (element.label === 'MONTAGEART') {
      //       query += ` AND MONTAGEART = '${element.value}'`
      //     }
      //   })
      // }

      // Abfrage beenden
      query += 'order by 1 asc'

      // Abfrage ausführen
      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Keine Ergebnisse gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen der Figur:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
