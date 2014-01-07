Account.create!(email: 'mike+la1@ubersense.com', hashed_pwd: '1f8ac10f23c5b5bc1167bda84b833e5c057a77d2', first_name: 'Launch', last_name: 'Academy1')
Account.create!(email: 'mike+la2@ubersense.com', hashed_pwd: '1f8ac10f23c5b5bc1167bda84b833e5c057a77d2', first_name: 'Launch', last_name: 'Academy2')
Account.create!(email: 'mike+la3@ubersense.com', hashed_pwd: '1f8ac10f23c5b5bc1167bda84b833e5c057a77d2', first_name: 'Launch', last_name: 'Academy3')

Person.get_person_for_guid(Person.guid_construction(nil, 'joe@example.com', nil, 'Joe Schmo'), 'Joe Schmo', 'joe@example.com')
Person.get_person_for_guid(Person.guid_construction(nil, 'foo@example.com', nil, 'Foo Bar'), 'Foo Bar', 'foo@example.com')
Person.get_person_for_guid(Person.guid_construction(nil, 'fred@example.com', nil, 'Fred Flintstone'), 'Fred Flintstone', 'fred@example.com')
