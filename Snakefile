rule test:
    output:
        'results/foo.txt'
    threads:
        2
    log:
        'results/logs/test.log'
    run:
        shell('echo {threads} > {output}; echo "logged" > {log}')

