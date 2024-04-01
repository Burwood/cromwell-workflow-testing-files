workflow myWorkflow1Task {
    input {
        String name
    }
    call myTask {
        input: name = name
    }
}

task myTask {
    input {
        String name
    }
    command {
        echo "hello ${name}!"
    }

    runtime {
        docker: "debian:latest"
        bootDiskSizeGb: 50
        zones: "us-central1-a"
    }

}