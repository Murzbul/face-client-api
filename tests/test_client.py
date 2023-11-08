import unittest
from main import app


class BasicTests(unittest.TestCase):

    def setUp(self):
        # App config on test context
        self.app = app.test_client()
        self.app.testing = True

    def test_add_client(self):
        # Test client creation
        data = {'name': 'Test Client', 'money': 100}
        response = self.app.post('/api/clients/add', json=data)
        print(response)
        self.assertEqual(response.status_code, 201)

    def test_index(self):
        # Send a request to '/api/clients' route on GET method
        response = self.app.get('/api/clients')
        self.assertEqual(response.status_code, 200)


if __name__ == '__main__':
    unittest.main()
