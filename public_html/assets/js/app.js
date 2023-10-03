/*
 * FETCH JSON SERVICE
 */
const fetchJson = async (url, data, method = 'get') => {
  const headers = {
    method
  }

  if (method === 'POST') {
    headers.body = data
  }

  const retorno = {
    statusCode: 404,
    body: 'not found'
  }

  // faz o request
  const request = await fetch(url, headers)

  if (request.status === 200 && request.headers.get('content-type').includes('json')) {
    // converte o resultado da request em json
    const body = await request.json()
    // define retorno da resposta
    retorno.statusCode = request.status
    console.log('JSONbody :>> ', body)
    retorno.body = body
  } else {
    const body = await request.json()
    // define retorno
    retorno.statusCode = request.status == 200 ? 400 : request.status

    retorno.body = body
  }

  return retorno
}

const fillList = (selector, data, key = 'name') => {
  const list = document.querySelector(selector)
  list.innerHTML = ''

  const rows = data.map(
    (row) => `<li class="list-group-item list-group-item-action">${row[key]}</li>`
  )

  list.innerHTML = rows.join('')
}

const fillTable = (selector, data) => {
  const table = document.querySelector(selector)
  table.innerHTML = ''

  if (!data.length) return
  // create table header Data
  const hData = Object.keys(data[0])

  const rows = data.map((row) => {
    const rData = []
    for (const key of hData) {
      rData.push(row[key])
    }
    return `<tr><td>${rData.join('</td><td>')}</td></tr>`
  })

  table.innerHTML = `<thead><tr><th>${hData.join('</th><th>')}</th></tr></thead>` + rows.join('')
}

const fillSelect = (selector, data, callback) => {
  // define o elemento select a ser alimentado
  const selectToFill = document.querySelector(selector)
  const selectOptions = []
  selectToFill.innerHTML = '<option value="">loading data...</option>'
  selectToFill.classList.remove('is-invalid')

  for (const obj of data) {
    const [key, val] = Object.keys(obj)
    selectOptions.push(`<option value="${obj[key]}">${obj[val]}</option>`)
  }

  if (selectOptions.length) {
    selectToFill.innerHTML = selectOptions.join()
    selectToFill.disabled = false
  } else {
    selectToFill.classList.add('is-invalid')
    selectToFill.disabled = true
    selectToFill.innerHTML = '<option value="">No registers found.</option>'
  }

  callback(selectToFill)
}

// carregar os dados do primeiro select
fetchJson('api/first').then(({ body }) =>
  fillSelect('#firstSelect', [{ id: '', val: 'Select an option' }, ...body], (e) => {
    fillTable('#firstTable', body)
    fillList('#firstList', body, 'name')
  })
)

// ouvir o evento change do primeiro select
const selectsToFillAnother = document.querySelectorAll('select[data-target][data-href]')

for (const select of selectsToFillAnother) {
  select.onchange = ({ target }) => {
    const id = target.value
    const href = target.dataset.href
    const targetSelect = target.dataset.target
    const positionElement = targetSelect.startsWith('#second') ? 'second' : 'third'
    if (id) {
      fetchJson(`api/${href}/${id}`).then(({ body }) => {
        fillSelect(targetSelect, body, (e) => {
          e.dispatchEvent(new Event('change'))
        })
        fillTable(`#${positionElement}Table`, body)
        fillList(`#${positionElement}List`, body, 'name')
      })
    } else {
      fillSelect(targetSelect, [{ id: '', value: 'Select a Previous Select option' }], (e) => {
        e.dispatchEvent(new Event('change'))
      })
      console.log('positionElement :>> ', positionElement)
      fillTable(`#${positionElement}Table`, [])
      fillList(`#${positionElement}List`, [], '')
    }
  }
}
