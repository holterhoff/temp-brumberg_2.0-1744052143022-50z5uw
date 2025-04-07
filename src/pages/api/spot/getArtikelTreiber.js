'use server'

import { neon } from '@neondatabase/serverless'

const sql = neon(process.env.DATABASE_URL)

export default async function getArtikelLED(req, res) {
  if (req.method == 'POST') {
    let params = JSON.parse(req.body)

    let sql =
      'SELECT DISTINCT TOP 1  position = 2, Menge = ' +
      params.A_Menge_Treiber +
      ' , Bezeichnung_Treiber_DE as Bezeichnung, Typ_Treiber as Typ,  Artikelnummer_Treiber as Artikelnummer,  Datenblatt_Treiber_DE as Datenblatt, Preis_Treiber as Preis FROM fakt.spot where Artikelnummer_Treiber =' +
      params.E_Artikelnummer_Treiber

    sql += ' ORDER BY 1'

    const result = await query(sql)

    if (result) {
      res.status(200).json(result)
    } else {
      res.status(500).json({ message: 'Fehler beim Login' })
    }
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
