import subprocess
import logging
logging.basicConfig(format='%(levelname)s:%(message)s', level=logging.DEBUG)


def run_unix_cmd(args_list):
    """
    run linux commands
    """
    print('Running system command:{0}'.format('     '.join(args_list)))
    proc = subprocess.Popen(args_list, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE, universal_newlines=True)
    s_output, s_err = proc.communicate()
    s_return = proc.returncode
    return s_return, s_output, s_err


def sqoop_job():
    """
    Create Sqoop job
    """

    table_names = [
        "vehicle_status",
        "vehicles",
        "client_status",
        "clients",
        "subsidiaries",
        "dispatcher_status",
        "dispatchers",
        "rents"
    ]

    standardCmd = [
        'sqoop', 'import', '--connect', 'jdbc:postgresql://127.0.0.1/dep',
        '--username', 'postgres', '--password', '123456', '--table', '$table_name',
        '--hive-database', 'rentacar', '--hive-import', '--hive-overwrite',
        '--create-hive-table', '--hive-table', '$table_name',
        '--warehouse-dir', '/home/cloudera/dep/$table_name', '-m', '1',
        '--', '--schema', 'relational'
    ]
    
    for table_name in table_names:
        cmd = [x.replace("$table_name", table_name) if '$table_name' in x else x for x in standardCmd]
        print("\n" * 3 + ('-' * 20) + 'starting new import table' + ('-' * 20))
        print(cmd)
        (ret, out, err) = run_unix_cmd(cmd)
        print(ret, out, err)
        if ret == 0:
            logging.info('Success.')
        else:
            logging.info('Error.')


if __name__ == '__main__':
    sqoop_job()