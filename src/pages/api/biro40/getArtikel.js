'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getArtikel(req, res) {
  if (req.method === 'GET') {
    // ID aus den Query-Parametern holen
    const { id } = req.query

    if (!id) {
      res.status(400).json({ message: 'ID fehlt in der Anfrage.' })
      return
    }

    try {
      // Parametrisierte Abfrage
      const query = `
        SELECT
          preis::DECIMAL(18,2) AS preis,
          kurztext,
          beschreibung,
          artikelnummer
        FROM biro40_artikel
        WHERE ID = '${id}'
        ORDER BY preis
      `

      // Abfrage mit Neon
      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Artikel nicht gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen des Artikels:', error)
      res.status(500).json({ message: 'Interner Serverfehler' })
    }
  } else {
    res.status(405).json({ message: 'Method not allowed' })
  }
}
