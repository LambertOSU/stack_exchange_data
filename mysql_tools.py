################################################################################
# mysql_tools.py

# This module contains classes which facilitate MySQL queries.

# -------------------
# Required Packages
#   -  mysql
#   -  mysql.connector
#   -  pandas

################################################################################
# package management
import mysql
import mysql.connector
import pandas as pd

################################################################################
# easy_sql

# The easy_sql class connects to a mysql
# database using the mysql connector and
# executes queries. At present, the query
# can be returned as a pandas DataFrame
# or a NumPy array.

# METHODS
#---------------------------------------------------------------
# easy_sql.use_db()          -  Sets the DATABASE to be used in
#                               the connection.
#---------------------------------------------------------------
# easy_sql.query_to_pandas() -  Executes a query given in string
#                               format and returns the results
#                               in a pandas DataFrame.
#---------------------------------------------------------------
# easy_sql.query_to_numpy()  -  Executes a query given in string
#                               format and returns the results
#                               in a NumPy array.
#---------------------------------------------------------------
class easy_sql:

    # initialize the instance
    def __init__(self,db=None):
        self.host = 'localhost'
        self.user = 'python_connection'
        self.password = 'demo_pass'
        self.database = db
        self.connection = None
        self.cursor = None

    # open the connection
    def _open(self):
        self.connection = mysql.connector.connect(host=self.host,
                                                user=self.user,
                                                password=self.password,
                                                database=self.database)
    # close the connection
    def _close(self):
        self.connection.close()

    # set the DATABASE
    def use_db(self,db):
        self.database = db

    # run the query and put the results
    # in a pandas DataFrame
    def query_to_pandas(self,query):
        self._open()
        df = pd.read_sql(query, con=self.connection)
        self._close()
        return df

    # run the query and put the results
    # in a NumPy array
    def query_to_numpy(self,query):
        self._open()
        df = pd.read_sql(query, con=self.connection)
        np_array = df.as_matrix()
        self._close()
        return np_array
################################################################################
