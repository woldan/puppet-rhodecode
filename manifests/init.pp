define rhodecode(
  $data_path,
  $repo_path,
  $python_env,
  $admin_pass,
  $admin_user,
  $admin_mail,
  $port = 5000
) {

  rhodecode::install { $data_path :
    data_path  => $data_path,
    python_env => $python_env,
  }

  rhodecode::config { $data_path :
    require    => Rhodecode::Install[$data_path],
    data_path  => $data_path,
    repo_path  => $repo_path,
    python_env => $python_env,
    admin_pass => $admin_pass,
    admin_user => $admin_user,
    admin_mail => $admin_mail,
    port       => $port,
  }

  rhodecode::service { $data_path :
    require    => Rhodecode::Config[$data_path],
    data_path  => $data_path,
    python_env => $python_env,
  }

}
