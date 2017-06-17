#!/usr/bin/perl
use 5.10.1;
use strict;
use warnings;
use Cwd;

# if the machine for the current vagrant dir isn't running, then shut down
# other vagrant boxes and then boot up the current one
# finally, vagrant ssh in

die "Not in a Vagrant directory" unless -e "Vagrantfile";

my $cwd = getcwd;

# find the vagrant path for each vm
my $vms = `VBoxManage list runningvms`;
my @vms = $vms =~ m/{(.*?)}/g;
my %path;
my $is_running = 0;
for my $uuid (@vms) {
    my $info = `VBoxManage showvminfo $uuid --machinereadable`;
    my ($path) = $info =~ /^SharedFolderPathMachineMapping1="(.+)"$/m or die "Unable to find SharedFolderPathMachineMapping1 for $info";
    $path{$uuid} = $path;
    $is_running = 1 if $path eq $cwd;
}

# if we're not running, shut down the other VMs and then power ours up
if (!$is_running) {
    for my $uuid (@vms) {
        chdir $path{$uuid};
        system("vagrant halt");
    }

    chdir $cwd;
    system("vagrant up");
}

# rsync over any config changes
my $ssh_config = `vagrant ssh-config`;
my $ssh_args = join " ", map { s/^  (\w+)\s+(.+)$/-o $1=$2/r } grep { /^\s+\S/ } split /\n/, $ssh_config;

system(
    "rsync",
    "-Lrz",
    "-e", "ssh $ssh_args",

    "$ENV{HOME}/.vimrc",
    "$ENV{HOME}/.vim",
    "$ENV{HOME}/.ssh",
    "--exclude", ".ssh/authorized_keys",
    "$ENV{HOME}/.gitconfig",

    "localhost:"
) and die $!;

exec("vagrant ssh");

