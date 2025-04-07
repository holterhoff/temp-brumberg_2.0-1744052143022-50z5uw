'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getArtikelLED(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let query = `

      SELECT DISTINCT
      2 as Position,
      ${params.A_Menge_Treiber} as Menge,
      bezeichnung_treiber_de as Bezeichnung,
      typ_treiber as Typ,
      artikelnummer_treiber as Artikelnummer,
      datenblatt_treiber_de as Datenblatt,
      preis_treiber as Preis

      FROM m1
      where artikelnummer_treiber = '${params.E_Artikelnummer_Treiber}'
    `

    query += ' ORDER BY 1'

    const result = await sql(query)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
