from setuptools import find_packages, setup
from pathlib import Path

__version__ = None
version_path = Path(__file__).parent / 'snowddl' / 'version.py'
exec(version_path.read_text())

setup(
    name='snowddl',
    version=__version__,
    description='Object management automation tool for Snowflake',
    long_description="""
        SnowDDL is an advanced tool for object management automation in Snowflake.

        Getting started: [https://docs.snowddl.com/getting-started](https://docs.snowddl.com/getting-started)

        Main features: [https://docs.snowddl.com/features](https://docs.snowddl.com/features)

        1. SnowDDL is "stateless".
        2. SnowDDL provides built-in "Role hierarchy" model.
        3. SnowDDL supports ALTER TABLE ... ALTER COLUMN.
        4. SnowDDL re-creates invalid views automatically.
        5. SnowDDL assists your team in code review.
        6. SnowDDL supports "env prefix".
        7. SnowDDL strikes a good balance between dependency management overhead and parallelism.
        8. SnowDDL costs very little.
        9. SnowDDL configuration can be generated dynamically in Python code.

        Enjoy!
    """,
    long_description_content_type='text/markdown',
    url='https://github.com/littleK0i/snowddl',
    author='Vitaly Markov',
    author_email='wild.desu@gmail.com',

    classifiers=[
        'Development Status :: 4 - Beta',
        'License :: OSI Approved :: Apache Software License',
        'Operating System :: OS Independent',
        'Intended Audience :: Developers',
        'Topic :: Database',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3.10',
    ],

    keywords='snowflake database schema object change ddl sql create alter drop grant',

    packages=find_packages(),
    include_package_data = True,

    entry_points={
        'console_scripts': [
            'snowddl = snowddl.__main__:default_entry_point',
            'snowddlconv = snowddl.__main__:convert_entry_point'
        ],
    },

    install_requires=[
        'snowflake-connector-python',
        'pyyaml',
        'jsonschema',
    ],

    extras_require={
        'test': ['pytest', 'pytest-xdist'],
    },

    python_requires='>=3.7',
)
