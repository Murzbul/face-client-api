import os

basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    DEBUG = False
    TESTING = False
    CSRF_ENABLED = True
    SECRET_KEY = os.environ.get('SECRET_KEY', 'you-will-never-guess')
    # Default fallback to SQLite if no env variable is set
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URI', 'sqlite:///' + os.path.join(basedir, 'app.db'))


class DevelopmentConfig(Config):
    DEBUG = True
    # Use a development database if specified, otherwise fallback to the Config's URI
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URI', Config.SQLALCHEMY_DATABASE_URI)


class TestingConfig(Config):
    TESTING = True
    DEBUG = True
    # Use a testing database if specified, otherwise use an in-memory SQLite database
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URI', 'sqlite:///:memory:')
    WTF_CSRF_ENABLED = False  # Useful for testing forms without needing a CSRF token.


class ProductionConfig(Config):
    # Use the production database; fallback to Config's URI if none is specified
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URI', Config.SQLALCHEMY_DATABASE_URI)
    # Ensure these are set to False in production for security
    DEBUG = False
    TESTING = False
