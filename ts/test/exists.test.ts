
import { test, describe } from 'node:test'
import { equal } from 'node:assert'


import { FunisgoStreamingSDK } from '..'


describe('exists', async () => {

  test('test-mode', async () => {
    const testsdk = await FunisgoStreamingSDK.test()
    equal(null !== testsdk, true)
  })

})
