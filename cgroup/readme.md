Cgroup 是 Linux kernel 的一项功能：它是在一个系统中运行的层级制进程组，你可对其进行资源分配（如 CPU 时间、系统内存、网络带宽或者这些资源的组合）。通过使用 cgroup，系统管理员在分配、排序、拒绝、管理和监控系统资源等方面，可以进行精细化控制。硬件资源可以在应用程序和用户间智能分配，从而增加整体效率。


cgroup 和 namespace 类似，也是将进程进行分组，但它的目的和 namespace 不一样，namespace 是为了隔离进程组之间的资源，而 cgroup 是为了对一组进程进行统一的资源监控和限制。

cgroup 是 Linux 下的一种将进程按组进行管理的机制，在用户层看来，cgroup 技术就是把系统中的所有进程组织成一颗一颗独立的树，每棵树都包含系统的所有进程，树的每个节点是一个进程组，而每颗树又和一个或者多个 subsystem 关联，树的作用是将进程分组，而 subsystem 的作用就是对这些组进行操作。cgroup 主要包括下面两部分：

subsystem : 一个 subsystem 就是一个内核模块，他被关联到一颗 cgroup 树之后，就会在树的每个节点（进程组）上做具体的操作。subsystem 经常被称作 resource controller，因为它主要被用来调度或者限制每个进程组的资源，但是这个说法不完全准确，因为有时我们将进程分组只是为了做一些监控，观察一下他们的状态，比如 perf_event subsystem。到目前为止，Linux 支持 12 种 subsystem，比如限制 CPU 的使用时间，限制使用的内存，统计 CPU 的使用情况，冻结和恢复一组进程等，后续会对它们一一进行介绍。
hierarchy : 一个 hierarchy 可以理解为一棵 cgroup 树，树的每个节点就是一个进程组，每棵树都会与零到多个 subsystem 关联。在一颗树里面，会包含 Linux 系统中的所有进程，但每个进程只能属于一个节点（进程组）。系统中可以有很多颗 cgroup 树，每棵树都和不同的 subsystem 关联，一个进程可以属于多颗树，即一个进程可以属于多个进程组，只是这些进程组和不同的 subsystem 关联。目前 Linux 支持 12 种 subsystem，如果不考虑不与任何 subsystem 关联的情况（systemd 就属于这种情况），Linux 里面最多可以建 12 颗 cgroup 树，每棵树关联一个 subsystem，当然也可以只建一棵树，然后让这棵树关联所有的 subsystem。当一颗 cgroup 树不和任何 subsystem 关联的时候，意味着这棵树只是将进程进行分组，至于要在分组的基础上做些什么，将由应用程序自己决定，systemd 就是一个这样的例子。

如果想严格控制 CPU 资源，设置 CPU 资源的使用上限，即不管 CPU 是否繁忙，对 CPU 资源的使用都不能超过这个上限。可以通过以下两个参数来设置：
cpu.cfs_period_us = 统计CPU使用时间的周期，单位是微秒（us） 
cpu.cfs_quota_us = 周期内允许占用的CPU时间(指单核的时间，多核则需要在设置时累加) 

systemctl 可以通过 CPUQuota 参数来设置 CPU 资源的使用上限。例如，如果你想将用户 tom 的 CPU 资源使用上限设置为 20%，可以执行以下命令：
$ systemctl set-property user-1000.slice CPUQuota=20%

如果你想通过配置文件来设置 cgroup，service 可以直接在 /etc/systemd/system/xxx.service.d 目录下面创建相应的配置文件，slice 可以直接在 /run/systemd/system/xxx.slice.d 目录下面创建相应的配置文件。事实上通过 systemctl 命令行工具设置 cgroup 也会写到该目录下的配置文件中：



有两种方法来查看系统的当前 cgroup 信息。第一种方法是通过 systemd-cgls 命令来查看，它会返回系统的整体 cgroup 层级，cgroup 树的最高层由 slice 构成，如下所示：

$ systemd-cgls --no-page
systemd-cgls 命令提供的只是 cgroup 层级的静态信息快照，要想查看 cgroup 层级的动态信息，可以通过 systemd-cgtop 命令查看：
systemd-cgtop

 CPU shares 可以用来设置 CPU 的相对使用时间，接下来我们就通过实践来验证一下。

 CPU controller 提供了两种方法来限制 CPU 使用时间，其中 CPUShares 用来设置相对权重，CPUQuota 用来限制 user、service 或 VM 的 CPU 使用时间百分比。例如：如果一个 user 同时设置了 CPUShares 和 CPUQuota，假设 CPUQuota 设置成 50%，那么在该 user 的 CPU 使用量达到 50% 之前，可以一直按照 CPUShares 的设置来使用 CPU。

对于内存而言，在 CentOS 7 中，systemd 已经帮我们将 memory 绑定到了 /sys/fs/cgroup/memory。systemd 只提供了一个参数 MemoryLimit 来对其进行控制，该参数表示某个 user 或 service 所能使用的物理内存总量