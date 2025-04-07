'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getSearch(req, res) {
  if (req.method === 'POST') {
    try {
      const params = JSON.parse(req.body)

      // ID parsen
      const parseIdToJson = id => {
        const idParts = id.split('-')

        return {
          kep_id: idParts[0],
          figur_index: idParts[1],
          schenkela: idParts[2],
          schenkelb: idParts[3],
          schenkelc: idParts[4],
          schenkeld: idParts[5]
        }
      }

      const parsedJson = parseIdToJson(params.id)
      if (!parsedJson) {
        return res.status(400).json({ message: 'Ungültige ID' })
      }

      // Grundabfrage
      let query = `
        SELECT DISTINCT
          figur,
          figur_index,
          montageart,
          gehaeusefarbe AS gehäusefarbe,
          lichtfarbe,
          ansteuerung,
          optisches_system AS optischessystem
      `

      // Dynamisch `schenkel`-Felder hinzufügen
      switch (parsedJson.figur_index) {
        case 'I':
          query += `, '${parsedJson.schenkela}' AS ia`
          break
        case 'L':
          query += `, '${parsedJson.schenkela}' AS la, '${parsedJson.schenkelb}' AS lb`
          break
        case 'U':
          query += `, '${parsedJson.schenkela}' AS ua, '${parsedJson.schenkelb}' AS ub, '${parsedJson.schenkelc}' AS uc`
          break
        case 'O':
          query += `, '${parsedJson.schenkela}' AS oa, '${parsedJson.schenkelb}' AS ob`
          break
        default:
          console.error('Unbekannter figur_index:', parsedJson.figur_index)
          return res.status(400).json({ message: 'Ungültiger figur_index' })
      }

      query += ` FROM biro40_kep WHERE KEP_ID = ${parsedJson.kep_id} AND FIGUR_INDEX = '${parsedJson.figur_index}' ORDER BY 1`

      // Abfrage ausführen
      const result = await sql(query)

      if (result.length > 0) {
        res.status(200).json(result)
      } else {
        res.status(404).json({ message: 'Keine Ergebnisse gefunden.' })
      }
    } catch (error) {
      console.error('Fehler beim Abrufen von KEP:', error)
      res.status(500).json({ message: 'Interner Serverfehler', error: error.message })
    }
  } else {
    res.status(405).json({ message: 'Methode nicht erlaubt' })
  }
}
