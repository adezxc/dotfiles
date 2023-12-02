let
  
  adam = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJz8iSHXaLJ4+S+LNz4XOwMsBZh81k1nIFLifPstERyP adam@antimage";

  antimage = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBlORGV+aTRsIIK0hpjiU6xpca0ztlviN3t9vA6zecmP root@nixos";

  users = [ adam ];
  systems = [ antimage ];
in
{
  "wireless.age".publicKeys = systems ++ users; 
}
