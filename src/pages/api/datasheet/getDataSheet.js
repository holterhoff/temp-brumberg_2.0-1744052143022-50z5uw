import query from '../dbservice'

export default async function getDataSheet(req, res) {
  if (req.method == 'GET') {
    const data = {
      invoices: [
        {
          id: '01-00-1234567890',
          leuchtenform: 'Gerade -I',
          montage: 'anbau',
          issuedDate: `13 12 2020}`,
          address: '7777 Mendez Plains',
          company: 'Hall-Robbins PLC',
          companyEmail: 'don85@johnson.com',
          country: 'USA',
          contact: '(616) 865-4180',
          name: 'Jordan Stevenson',
          service: 'Software Development',
          total: 3428,
          avatar: '',
          avatarColor: 'primary',
          invoiceStatus: 'Paid',
          balance: '$724',
          dueDate: `23 12 2023`
        }
      ]
    }

    res.status(200).json(data)
  } else {
    res.status(401).json({ message: 'This Methode not allowed' })
  }
}
