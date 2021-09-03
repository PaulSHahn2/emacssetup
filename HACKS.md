# Manually fixed stuff

Stuff I have had to hack on to fix.

## dired-speedbar term mode integration

This is borked for me out of the box. 

I can fix this in dired-sidebar.el if I change function
dired-sidebar-term-get-pwd:

```lisp
(defun dired-sidebar-term-get-pwd ()
  "Get current directory of `term-mode'.

This is still somewhat experimental/hacky and now hardcoded to prompt.
  (interactive)
  (condition-case nil
      (progn
        ;;(message (elt split-string(elt(split-string((thing-at-point 'line) ":") 1) "$") 0))
        (let ((result (elt split-string(elt(split-string((thing-at-point 'line) ":") 1) "$")0)))
          result))
    (error
     default-directory)))
```

I am obviously no lisp programmer. This is simpler and just relies on your
 prompt already having your pwd as part of its contents.

Of course this approach depends on your shell setting the pwd in the prompt and
it being delimited with a colon to begin the prompt and a dollar sign to end
it. If the pwd in the prompt gets truncated, isn't displayed or has different
delimiters, this breaks or needs adjustment. 

However, this has the advantage of actually working, so you could argue it is
less of a hack than the previous approach which always seemed broke if you
switched from char to line mode or vice-versa. That approach meant you had to
have the cursor somewhere close to the prompt or it broke. Line mode, screen or
other programs meant this happened regularly. 

Plus the old approach always ran pwd commands putting stuff in your history and
moving your shell around while you were trying to use it. If it goofed and got
it wrong, it deleted some of your buffer contents and left its pwd command
remnants behind.

For the record my shell is bash and my prompt on Ubuntu is set as:

```bash
PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
```

## Remote port forwarding and tramp

Lets say you have a machine with a firewall active that you do not manage and
cannot change. The machine can ssh to any other machine on your local network,
but you cannot ssh into it even though it is running an sshd service. The
firewall blocks incoming access from your LAN.

In our instance this is typically a Windows machine provided by an employer or
institution-- so we will refer to it as "the Windows machine". It can really be
any machine running any host OS with a firewall set to block incoming
connections.

Now you could try to run your Windows sshd instance on a port that the firewall
lets through, like some UDP printing port. Or you could apply to get access to
configure your firewall and fix your problem that way. Last, you could say stuff
it and just copy your work to another more capable machine and then copy it back
again. This last approach is frequently against security policy and for good
reason.

So another alternative is port forwarding.

Once you setup remote port forwarding you can connect to the Windows machine
from any other machine in your LAN. We can then edit local files remotely in
tramp mode without them leaving the Windows machine. Further, we can port
forward web services and access them from other LAN machines.

To do this, you will need:

1. An instance of sshd running on the Windows machine. It can run natively on
   the Windows machine or inside a virtual machine hosted by it and sharing the same IP (NAT).
2. The standard CLI ssh client on the Windows machine that can punch out to a remote sshd server.
3. An instance of sshd running on another remote machine on the LAN that is open
   to connections from the rest of the LAN. We will call this "the Linux
   machine", but it can be a machine running any OS. It is often your wireless
   router itself, if it is capable of running sshd.

First, on the Windows machine run the ssh client command to punch out to another sshd instance:

```bash
ssh -p {REMOTE_LINUX_MACHINES_SSH_SERVER_PORT_HERE} -R 8080:172.0.0.1:22 -N -f {YOUR_LINUX_REMOTE_MACHINE_USERNAME}@YOUR_LINUX_REMOTE_MACHINE_IP_ADDRESS_OR_HOSTNAME
```

If your Linux machine runs *sshd* on the default port, 22-- you can eliminate
"-p {REMOTE_LINUX_MACHINES_SSH_SERVER_PORT_HERE}".  You only need this if your
sshd service on your Linux machine runs on a non-default port. In that case, you
must tell the ssh client the port number to connect to.

This command tells the ssh client on your Windows machine to open a connection
from it to the Linux machine in the background (-f). It tells the Linux machine
to take this new connection and instead of just giving you a shell prompt to the
remote Linux machine-- make the connection available locally on the Linux
machine on port 8080. It makes the connection go back to the local port 22 on
the Windows machine. It is now a relay that forwards everything sent to 8080 on
the incoming end to 22 on the Windows machine. Port 22 in this example needs to
be the port where you are running sshd on Windows, adjust the port argument to
match your port if nonstandard. You can also substitute a different port for
8080 if you wish.

After running the command, the client returns and appears to have done
nothing. However, network tools will show that you now have a connection from
your Windows machine opened to the Linux machine, the same as if you had
"ssh-ed" into it.

On your Linux machine, you should be able to connect back to the Windows sshd
service now, using the new local 8080 port.

This means that instead of trying to connect directly to the Windows IP address
and port blocked by firewall, you just connect to the Linux machines localhost
at port 8080 and it forwards you to the Windows sshd instance through the tunnel
you opened:

```bash
ssh -p 8080 YOURWINDOWSUSERNAME@127.0.0.1
```

Hence the name, port forwarding. You can usually use *localhost* instead of 127.0.0.1 here.


If you want to connect from some other machine in your local network, use the
Linux machine's resolvable hostname or IP address and port 8080 and it will
forward to the Windows machine as well. For example if your Linux machine is at 192.168.1.11:

```bash
ssh -p 8080 yourwindowsusername@192.168.1.11
```


If you run a capable wireless router that runs *sshd*, such as OpenWRT-- you can
use the router to make your Window's machine accessible to the rest of your LAN
instead of having to use a separate *Linux machine* to do so.

You can also forward any service that listens on a port, not just *sshd*. For
example to forward your web application running on Windows port 80 to your linux
machine at port 8080, we run the same command but use port 80 instead of 22:

```bash
ssh -p {REMOTE_LINUX_MACHINES_SSH_SERVER_PORT_HERE} -R 8080:172.0.0.1:80 -N -f {YOUR_LINUX_REMOTE_MACHINE_USERNAME}@YOUR_LINUX_REMOTE_MACHINE_IP_ADDRESS_OR_HOSTNAME
```

Connecting with a web browser on the Linux machine to port 8080 will now show
the web application running on the Windows machine at port 80.

Taken together, both of these features are very handy for several reasons:

1. Issued laptops are frequently under-powered and doing all development tasks on one machine strains or breaks them.
2. A laptop run one OS by default, and cross browser client testing is not always possible, or is a PITA and requires virtual machines.
3. Setting up *emacs* on Windows is a pain. Even when possible, running a full-fledged *emacs* with LSP and whatever else adds to the strain.
4. KVM switches are now garbage thanks to HDMI being a crap protocol. Trying to
   share a computer display between work and home computers is
   problematic. Switching is difficult and time consuming. Your windows machine
   almost never remembers window affinity for your applications and you have to
   re-drag them to the screen you want them to be on. Even when it works
   acceptably (exwm), most KVM's can usually only share one screen between the
   two computers. So you end up with screens underutilized if you have more than
   one screen that could have been shared. This gets frustrating.

You can go back and forth between your personal email/im/web browsing and your
coding work without touching an annoying KVM switch.

Further, you can leave your Windows laptop screen open to display your IM or
email office application that keep you up-to-date. It is often easier to use the
laptop keyboard and touchpad to type quick responses on your laptop than it is
to deal with a KVM switch, screwing up your window management.

Now your Windows laptop has to at most run a few simple productivity apps, plus a
web server for whatever you are currently developing. 

The rest of the IDE tooling, and your web browsers with tons of plugins are not
running on the laptop, but on the more capable home computer. Since you are
using tramp, the work you are editing stays on the windows machine and doesn't
leave it. Your windows machine can access remote networks/VPNs and can still
connect and push code upstream.

The advantages of this are further multiplied if you have more than one
client/employer/project that you are working on (say Mac OS-X, smart-phones,
Windows browsers and Linux browsers).  When you want to manually test with
multiple clients and OSes against a central web service, you now have a central
endpoint to hit that isn't blocked by dorky firewall rules. You don't have to
deal with IT exceptions that often take days or weeks, if granted at all.
