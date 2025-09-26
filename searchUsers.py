from ldap3 import Server, Connection, ALL

# LDAP server
server = Server('localhost', port=1389, get_info=ALL)

# Connect using Directory Manager (admin)
conn = Connection(server, user='cn=zerocool', password='admin', auto_bind=True)

# Search for all users
conn.search('ou=users,dc=moria,dc=org', '(objectClass=inetOrgPerson)', attributes=['uid','cn','mail'])

for entry in conn.entries:
    print(entry)
