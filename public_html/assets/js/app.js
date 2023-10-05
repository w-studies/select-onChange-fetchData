/**
 * FETCH JSON SERVICE
 * @param {*} url
 * @param {*} data
 * @param {*} method
 * @returns
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
  alertDiv.classList.add('d-none')
  // faz o request
  const request = await fetch(url, headers)

  if (request.status === 200 && request.headers.get('content-type').includes('json')) {
    // converte o resultado da request em json
    const body = await request.json()
    // define retorno da resposta
    retorno.statusCode = request.status

    retorno.body = body
  } else {
    const body = await request.json()
    // define retorno
    retorno.statusCode = request.status == 200 ? 400 : request.status

    alertDiv.innerHTML = body
    alertDiv.classList.remove('d-none')
    retorno.body = []
  }

  return retorno
}

/**
 * FILL LIST FUNCTION
 * @param {*} selector
 * @param {*} data
 * @param {*} key
 */
const fillList = (selector, data, key = 'name') => {
  const list = document.querySelector(selector)
  list.innerHTML = ''

  const rows = data.map(
    (row) => `<li class="list-group-item list-group-item-action">${row[key]}</li>`
  )

  list.innerHTML = rows.join('')
}

/**
 * FILL TABLE FUNCTION
 * @param {*} selector
 * @param {*} data
 * @returns
 */
const fillTable = (selector, data) => {
  const table = document.querySelector(selector)
  table.innerHTML = ''

  if (!data.length) return
  // create table header Data
  const hData = Object.keys(data[1] ?? data[0])

  const rows = data.map((row) => {
    const rData = []
    for (const key of hData) {
      rData.push(row[key])
    }
    return `<tr><td>${rData.join('</td><td>')}</td></tr>`
  })

  table.innerHTML = `<thead><tr><th>${hData.join('</th><th>')}</th></tr></thead>` + rows.join('')
}

/**
 * FILL SELECT FUNCTION
 * @param {*} selector
 * @param {*} data
 * @param {*} callback
 */
const fillSelect = (selector, data, callback) => {
  // define se select element to be feed
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
/**
 * FILL ALL FUNCTION
 * @param {*} target
 * @param {*} data
 * @param {*} nextElement
 */
const fillAll = (target, data, nextElement) => {
  fillSelect(target, data, (e) => {
    e.dispatchEvent(new Event('change'))
  })
  fillTable(`${nextElement}Table`, data)
  fillList(`${nextElement}List`, data, 'name')
}

// Load data for the first select
fetchJson('api/first').then(({ body }) => body.length && fillAll('#firstSelect', body, '#first'))

// Listen the changeEvent for all selects with [data-target][data-href]
const selectsToFillAnother = document.querySelectorAll('select[data-target][data-href]')

for (const select of selectsToFillAnother) {
  select.onchange = async ({ target }) => {
    const id = target.value
    const href = target.dataset.href
    const targetSelect = target.dataset.target
    const nextElement = targetSelect.startsWith('#second') ? '#second' : '#third'

    document.querySelector(targetSelect).innerHTML = '<option value="">loading data...</option>'
    fillTable(`${nextElement}Table`, [{ status: 'loading' }])
    fillList(`${nextElement}List`, [{ name: 'loading' }])

    let body = [{ id: '', value: 'Select a Previous Select option' }]

    if (id) {
      body = await fetchJson(`api/${href}/${id}`).then(({ body }) => body)
    }

    fillAll(targetSelect, body, nextElement)
  }
}
