Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Drawing, System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="pSentinel" Height="1050" Width="1400" Background="#08080A">
    <Window.Resources>
        <Style TargetType="Button" x:Key="NavBtn">
            <Setter Property="Background" Value="Transparent"/><Setter Property="Foreground" Value="#888888"/>
            <Setter Property="BorderThickness" Value="0"/><Setter Property="Height" Value="50"/><Setter Property="FontSize" Value="13"/>
            <Setter Property="HorizontalContentAlignment" Value="Left"/><Setter Property="Padding" Value="25,0,0,0"/>
            <Style.Triggers>
                <Trigger Property="IsMouseOver" Value="True"><Setter Property="Background" Value="#1A1A1D"/><Setter Property="Foreground" Value="#007ACC"/></Trigger>
            </Style.Triggers>
        </Style>
        <Style TargetType="TextBlock"><Setter Property="Foreground" Value="#DCDCDC"/></Style>
        <Style TargetType="DataGrid">
            <Setter Property="Background" Value="#111114"/><Setter Property="Foreground" Value="White"/><Setter Property="BorderThickness" Value="0"/>
            <Setter Property="RowBackground" Value="#161618"/><Setter Property="AlternatingRowBackground" Value="#111114"/><Setter Property="GridLinesVisibility" Value="None"/>
        </Style>
    </Window.Resources>

    <Grid>
        <Grid.ColumnDefinitions>
            <ColumnDefinition Width="240"/> <ColumnDefinition Width="*"/>
        </Grid.ColumnDefinitions>

        <Border Grid.Column="0" Background="#0D0D0F" BorderBrush="#1A1A1D" BorderThickness="0,0,1,0">
            <DockPanel>
                <StackPanel DockPanel.Dock="Top" Margin="25,40,20,30">
                    <TextBlock Text="pSentinel" FontSize="22" FontWeight="Bold" Foreground="#007ACC"/>
                    <TextBlock Text="Remote Administration" FontSize="10" Foreground="#555555" Margin="2,0,0,0"/>
                </StackPanel>
                
                <StackPanel>
                    <Button Name="navDash" Style="{StaticResource NavBtn}" Content="📊 Dashboard Overview"/>
                    <Button Name="navEvents" Style="{StaticResource NavBtn}" Content="🚨 System Events"/>
                    <Button Name="navProc" Style="{StaticResource NavBtn}" Content="⚙️ Active Processes"/>
                    <Button Name="navFile" Style="{StaticResource NavBtn}" Content="📂 File Explorer"/>
                    <Button Name="navNet"  Style="{StaticResource NavBtn}" Content="🌐 Network Audit"/>
                    <Button Name="navSec"  Style="{StaticResource NavBtn}" Content="🛡️ Security Center"/>
                    <Button Name="navSched" Style="{StaticResource NavBtn}" Content="⏳ Task Scheduler"/>
                    <Button Name="navSvc"  Style="{StaticResource NavBtn}" Content="🔧 System Services"/>
                    <Button Name="navSoftware" Style="{StaticResource NavBtn}" Content="📦 Software Audit"/>
                    <Button Name="navDrivers" Style="{StaticResource NavBtn}" Content="🔌 Driver Manager"/>
                    <Button Name="navScreen" Style="{StaticResource NavBtn}" Content="📸 Remote View"/>
                    <Button Name="navCons" Style="{StaticResource NavBtn}" Content="🐚 PowerShell Console"/>
                    <Separator Background="#1A1A1D" Margin="15,10"/>
                    <Button Name="navConfig" Style="{StaticResource NavBtn}" Content="🛠️ Remote Config"/>
                </StackPanel>
            </DockPanel>
        </Border>

        <DockPanel Grid.Column="1">
            <Border DockPanel.Dock="Top" Background="#0A0A0C" Padding="25,15" BorderBrush="#1A1A1D" BorderThickness="0,0,0,1">
                <Grid>
                    <StackPanel Orientation="Horizontal">
                        <Ellipse Name="statusDot" Width="10" Height="10" Fill="#FF5555" Margin="0,0,10,0"/>
                        <StackPanel VerticalAlignment="Center">
                            <TextBlock Name="lblGlobalHost" Text="REMOTE HOST: DISCONNECTED" FontWeight="Bold" FontSize="14"/>
                            <TextBlock Name="lblSubStatus" Text="Awaiting initial synchronization..." FontSize="10" Foreground="#555"/>
                        </StackPanel>
                    </StackPanel>
                    <Button Name="btnGlobalSync" HorizontalAlignment="Right" Content="CONNECT / SYNC" Width="160" Height="35" Background="#007ACC" Foreground="White" BorderThickness="0" FontWeight="Bold"/>
                </Grid>
            </Border>

            <StatusBar DockPanel.Dock="Bottom" Background="#007ACC" Height="25">
                <TextBlock Name="mainStatus" Text="Ready" Foreground="White" FontSize="11" Margin="15,0"/>
            </StatusBar>

            <TabControl Name="MainTabs" Background="Transparent" BorderThickness="0">
                <TabControl.Template><ControlTemplate TargetType="TabControl"><ContentPresenter ContentSource="SelectedContent"/></ControlTemplate></TabControl.Template>

                <!-- TAB 0: DASHBOARD -->
                <TabItem>
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel Margin="25">
                            <Grid Margin="0,0,0,20">
                                <StackPanel>
                                    <TextBlock Name="lblNodeName" Text="NODE: DISCONNECTED" FontSize="26" FontWeight="ExtraBold" Foreground="White"/>
                                    <TextBlock Name="lblNodeIP" Text="0.0.0.0 - Awaiting Telemetry" FontSize="11" Foreground="#666"/>
                                </StackPanel>
                                <Border HorizontalAlignment="Right" Background="#1A1A1D" CornerRadius="15" Padding="15,5">
                                    <StackPanel Orientation="Horizontal">
                                        <Ellipse Name="elStatus" Width="10" Height="10" Fill="#444" Margin="0,0,10,0"/>
                                        <TextBlock Name="txtStatus" Text="IDLE" Foreground="#888" VerticalAlignment="Center" FontWeight="Bold"/>
                                    </StackPanel>
                                </Border>
                            </Grid>

                            <UniformGrid Columns="4" Height="110">
                                <Border Background="#121214" Margin="4" CornerRadius="10" BorderBrush="#1A1A1D" BorderThickness="1">
                                    <StackPanel VerticalAlignment="Center" Margin="15,0">
                                        <TextBlock Text="CPU LOAD" Foreground="#007ACC" FontSize="10" FontWeight="Bold"/>
                                        <TextBlock Name="dashCPU" Text="--" FontSize="30" FontWeight="Bold" Foreground="White"/>
                                        <ProgressBar Name="pbCPU" Height="3" Background="#222" Foreground="#007ACC" BorderThickness="0" Margin="0,5,0,0"/>
                                    </StackPanel>
                                </Border>
                                <Border Background="#121214" Margin="4" CornerRadius="10" BorderBrush="#1A1A1D" BorderThickness="1">
                                    <StackPanel VerticalAlignment="Center" Margin="15,0">
                                        <TextBlock Text="MEM UTILIZATION" Foreground="#2ECC71" FontSize="10" FontWeight="Bold"/>
                                        <TextBlock Name="dashRAM" Text="--" FontSize="30" FontWeight="Bold" Foreground="White"/>
                                        <ProgressBar Name="pbRAM" Height="3" Background="#222" Foreground="#2ECC71" BorderThickness="0" Margin="0,5,0,0"/>
                                    </StackPanel>
                                </Border>
                                <Border Background="#121214" Margin="4" CornerRadius="10" BorderBrush="#1A1A1D" BorderThickness="1">
                                    <StackPanel VerticalAlignment="Center" Margin="15,0">
                                        <TextBlock Text="DISK C: HEALTH" Foreground="#E65100" FontSize="10" FontWeight="Bold"/>
                                        <TextBlock Name="dashDisk" Text="--" FontSize="30" FontWeight="Bold" Foreground="White"/>
                                        <ProgressBar Name="pbDisk" Height="3" Background="#222" Foreground="#E65100" BorderThickness="0" Margin="0,5,0,0"/>
                                    </StackPanel>
                                </Border>
                                <Border Background="#121214" Margin="4" CornerRadius="10" BorderBrush="#1A1A1D" BorderThickness="1">
                                    <StackPanel VerticalAlignment="Center" Margin="15,0">
                                        <TextBlock Text="NET RESPONSE" Foreground="#9C27B0" FontSize="10" FontWeight="Bold"/>
                                        <TextBlock Name="dashPing" Text="-- ms" FontSize="30" FontWeight="Bold" Foreground="White"/>
                                        <TextBlock Name="dashJitter" Text="STABLE" FontSize="9" Foreground="#444"/>
                                    </StackPanel>
                                </Border>
                            </UniformGrid>

                            <UniformGrid Columns="3" Height="110" Margin="0,15,0,0">
                                <Border Background="#121214" Margin="4" CornerRadius="10" BorderBrush="#1A1A1D" BorderThickness="1">
                                    <StackPanel VerticalAlignment="Center" Margin="15,0">
                                        <TextBlock Text="SYSTEM UPTIME" Foreground="#00BCD4" FontSize="10" FontWeight="Bold"/>
                                        <TextBlock Name="dashUptime" Text="-- d -- h" FontSize="24" FontWeight="Bold" Foreground="White"/>
                                        <TextBlock Text="Continuous Operation" FontSize="9" Foreground="#444" Margin="0,5,0,0"/>
                                    </StackPanel>
                                </Border>
                                <Border Background="#121214" Margin="4" CornerRadius="10" BorderBrush="#1A1A1D" BorderThickness="1">
                                    <StackPanel VerticalAlignment="Center" Margin="15,0">
                                        <TextBlock Text="LAST BOOT TIME" Foreground="#FFEB3B" FontSize="10" FontWeight="Bold"/>
                                        <TextBlock Name="dashBoot" Text="--:--:--" FontSize="18" FontWeight="Bold" Foreground="White"/>
                                        <TextBlock Name="dashBootDate" Text="--/--/----" FontSize="10" Foreground="#666"/>
                                    </StackPanel>
                                </Border>
                                <Border Background="#121214" Margin="4" CornerRadius="10" BorderBrush="#1A1A1D" BorderThickness="1">
                                    <StackPanel VerticalAlignment="Center" Margin="15,0">
                                        <TextBlock Text="OS ARCHITECTURE" Foreground="#9C27B0" FontSize="10" FontWeight="Bold"/>
                                        <TextBlock Name="dashOS" Text="--" FontSize="18" FontWeight="Bold" Foreground="White" TextWrapping="Wrap"/>
                                        <TextBlock Name="dashBuild" Text="Build: ----" FontSize="9" Foreground="#444"/>
                                    </StackPanel>
                                </Border>
                            </UniformGrid>

                            <Grid Margin="0,15">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="*"/><ColumnDefinition Width="*"/><ColumnDefinition Width="1.2*"/>
                                </Grid.ColumnDefinitions>

                                <Border Grid.Column="0" Background="#0D0D0F" Margin="4" CornerRadius="10" Padding="15" BorderBrush="#222" BorderThickness="1">
                                    <StackPanel>
                                        <TextBlock Text="SECURITY COMPLIANCE" Foreground="#007ACC" FontSize="10" FontWeight="Bold" Margin="0,0,0,10"/>
                                        <Grid Margin="0,4"><TextBlock Text="Firewall" Foreground="#777"/><TextBlock Name="stFW" Text="UNKNOWN" HorizontalAlignment="Right" Foreground="#444"/></Grid>
                                        <Grid Margin="0,4"><TextBlock Text="AV Real-Time" Foreground="#777"/><TextBlock Name="stAV" Text="UNKNOWN" HorizontalAlignment="Right" Foreground="#444"/></Grid>
                                        <Grid Margin="0,4"><TextBlock Text="Disk Encryption" Foreground="#777"/><TextBlock Name="stBit" Text="UNKNOWN" HorizontalAlignment="Right" Foreground="#444"/></Grid>
                                    </StackPanel>
                                </Border>

                                <Border Grid.Column="1" Background="#0D0D0F" Margin="4" CornerRadius="10" Padding="15" BorderBrush="#222" BorderThickness="1">
                                    <StackPanel>
                                        <TextBlock Text="NETWORK TOPOLOGY" Foreground="#007ACC" FontSize="10" FontWeight="Bold" Margin="0,0,0,10"/>
                                        <TextBlock Text="Primary Gateway" FontSize="9" Foreground="#555"/><TextBlock Name="stGW" Text="--.--.--.--" Margin="0,0,0,5" Foreground="#BBB"/>
                                        <TextBlock Text="Active DNS" FontSize="9" Foreground="#555"/><TextBlock Name="stDNS" Text="--.--.--.--" Foreground="#BBB"/>
                                    </StackPanel>
                                </Border>

                                <Border Grid.Column="2" Background="#140A0A" Margin="4" CornerRadius="10" Padding="15" BorderBrush="#331111" BorderThickness="1">
                                    <StackPanel>
                                        <TextBlock Text="USER SESSION" Foreground="#F44336" FontSize="10" FontWeight="Bold" Margin="0,0,0,10"/>
                                        <TextBlock Name="stUser" Text="NO SESSION" FontSize="18" Foreground="White" Margin="0,0,0,2"/>
                                        <TextBlock Name="stLogon" Text="Logon: --:--" FontSize="10" Foreground="#666"/>
                                        <TextBlock Name="stIdle" Text="Idle Time: --" FontSize="10" Foreground="#666"/>
                                    </StackPanel>
                                </Border>
                            </Grid>
                        </StackPanel>
                    </ScrollViewer>
                </TabItem>

                <!-- TAB 1: EVENTS -->
                <TabItem>
                    <Grid Margin="30">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/> <RowDefinition Height="Auto"/> <RowDefinition Height="Auto"/> <RowDefinition Height="*"/>    </Grid.RowDefinitions>

                        <StackPanel Grid.Row="0" Margin="0,0,0,20">
                            <TextBlock Text="System Forensics &amp; Audit" FontSize="28" FontWeight="ExtraBold" Foreground="White"/>
                            <TextBlock Text="Real-time event analysis across System, Security, and Application logs." Foreground="#666"/>
                        </StackPanel>

                        <UniformGrid Grid.Row="1" Columns="4" Height="100" Margin="0,0,0,20">
                            <Border Background="#1A0A0A" BorderBrush="#FF4444" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="CRITICAL ERRORS" Foreground="#FF4444" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntCritical" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="System Stability" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                            <Border Background="#1A150A" BorderBrush="#FFA500" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="AUTH FAILURES" Foreground="#FFA500" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntSecurity" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="Security Log 4625" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                            <Border Background="#0A121A" BorderBrush="#007ACC" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="DISK WARNINGS" Foreground="#007ACC" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntDisk" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="I/O &amp; Controller" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                            <Border Background="#0A1A0F" BorderBrush="#2ECC71" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="APP CRASHES" Foreground="#2ECC71" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntApp" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="Faulting Modules" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                        </UniformGrid>

                        <Border Grid.Row="2" Background="#111" CornerRadius="5" Padding="15,10" Margin="5,0,5,15" BorderBrush="#222" BorderThickness="1">
                            <DockPanel>
                                <TextBlock Text="🔍 FILTER LOGS:" VerticalAlignment="Center" Margin="0,0,15,0" Foreground="#007ACC" FontWeight="Bold" FontSize="11"/>
                                <TextBox Name="txtEventFilter" VerticalContentAlignment="Center" Background="Transparent" Foreground="White" BorderThickness="0" CaretBrush="White"/>
                            </DockPanel>
                        </Border>

                        <Border Grid.Row="3" Background="#050505" CornerRadius="10" Padding="10" BorderBrush="#1A1A1D" BorderThickness="1">
                            <DataGrid Name="dgEvents" AutoGenerateColumns="False" Background="Transparent" Foreground="#BBB" BorderThickness="0" IsReadOnly="True" RowHeight="35">
                                <DataGrid.Columns>
                                    <DataGridTextColumn Header="TIME" Binding="{Binding Time}" Width="140"/>
                                    <DataGridTextColumn Header="ID" Binding="{Binding ID}" Width="70"/>
                                    <DataGridTextColumn Header="SOURCE" Binding="{Binding Source}" Width="180"/>
                                    <DataGridTextColumn Header="MESSAGE" Binding="{Binding Message}" Width="*"/>
                                </DataGrid.Columns>
                            </DataGrid>
                        </Border>
                    </Grid>
                </TabItem>

                <!-- TAB 2: PROCESSES -->
                <TabItem>
                    <Grid Margin="30">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/> <RowDefinition Height="Auto"/> <RowDefinition Height="Auto"/> <RowDefinition Height="*"/>    <RowDefinition Height="Auto"/> </Grid.RowDefinitions>

                        <StackPanel Grid.Row="0" Margin="0,0,0,20">
                            <TextBlock Text="Process Intelligence" FontSize="28" FontWeight="ExtraBold" Foreground="White"/>
                            <TextBlock Text="Real-time telemetry of active execution threads and resource consumption." Foreground="#666"/>
                        </StackPanel>

                        <UniformGrid Grid.Row="1" Columns="4" Height="100" Margin="0,0,0,20">
                            <Border Background="#0A121A" BorderBrush="#007ACC" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="TOTAL PROCESSES" Foreground="#007ACC" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntTotalProc" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="Active Threads" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                            <Border Background="#1A0A0A" BorderBrush="#FF4444" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="HIGH CPU LOAD" Foreground="#FF4444" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntHighCPU" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="> 20% Utilization" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                            <Border Background="#1A150A" BorderBrush="#FFA500" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="SYSTEM SHELLS" Foreground="#FFA500" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntShells" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="PS / CMD / Bash" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                            <Border Background="#0A1A0F" BorderBrush="#2ECC71" BorderThickness="1" CornerRadius="10" Margin="5">
                                <StackPanel VerticalAlignment="Center">
                                    <TextBlock Text="ORPHANED/SUSP" Foreground="#2ECC71" FontSize="10" FontWeight="Bold" HorizontalAlignment="Center"/>
                                    <TextBlock Name="cntSuspicious" Text="0" FontSize="32" Foreground="White" HorizontalAlignment="Center" FontWeight="Bold"/>
                                    <TextBlock Text="Non-Responsive" FontSize="9" Foreground="#444444" HorizontalAlignment="Center"/>
                                </StackPanel>
                            </Border>
                        </UniformGrid>

                        <Border Grid.Row="2" Background="#111" CornerRadius="5" Padding="15,10" Margin="5,0,5,15" BorderBrush="#222" BorderThickness="1">
                            <DockPanel>
                                <TextBlock Text="🔍 SEARCH PROCESS:" VerticalAlignment="Center" Margin="0,0,15,0" Foreground="#007ACC" FontWeight="Bold" FontSize="11"/>
                                <TextBox Name="txtProcFilter" VerticalContentAlignment="Center" Background="Transparent" Foreground="White" BorderThickness="0" CaretBrush="White"/>
                            </DockPanel>
                        </Border>

                        <DataGrid Name="dgProcesses" Grid.Row="3" AutoGenerateColumns="False" IsReadOnly="True" Background="Transparent" BorderThickness="0">
                            <DataGrid.Columns>
                                <DataGridTextColumn Header="PID" Binding="{Binding Id}" Width="80"/>
                                <DataGridTextColumn Header="NAME" Binding="{Binding Name}" Width="250"/>
                                <DataGridTextColumn Header="CPU %" Binding="{Binding CPU}" Width="100"/>
                                <DataGridTextColumn Header="MEM (MB)" Binding="{Binding Mem}" Width="100"/>
                                <DataGridTextColumn Header="PATH" Binding="{Binding Path}" Width="*"/>
                            </DataGrid.Columns>
                        </DataGrid>

                        <StackPanel Grid.Row="4" Orientation="Horizontal" HorizontalAlignment="Right" Margin="0,15,0,0">
                            <Button Name="btnRefreshProc" Content="REFRESH" Width="120" Height="40" Margin="0,0,10,0" Background="#1A1A25" Foreground="White"/>
                            <Button Name="btnKill" Content="TERMINATE PROCESS" Width="160" Height="40" Background="#B71C1C" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                        </StackPanel>
                    </Grid>
                </TabItem>

                <!-- TAB 3: FILE EXPLORER -->
                <TabItem>
                    <Grid Margin="30">
                        <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="Auto"/><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                        <TextBlock Text="Remote File Explorer" FontSize="24" FontWeight="Bold" Margin="0,0,0,20"/>
                        <DockPanel Grid.Row="1" Margin="0,0,0,15">
                            <Button Name="btnGoUp" Content="DIR UP" Width="80" DockPanel.Dock="Left" Margin="0,0,5,0"/>
                            <Button Name="btnListFiles" Content="BROWSE" Width="100" DockPanel.Dock="Right" Background="#007ACC" Foreground="White"/>
                            <TextBox Name="txtFilePath" Text="C:\" VerticalContentAlignment="Center" Padding="10" Background="#111114" Foreground="White" BorderBrush="#333333"/>
                        </DockPanel>
                        <DataGrid Name="dgFiles" Grid.Row="2" AutoGenerateColumns="False" IsReadOnly="True">
                            <DataGrid.Columns>
                                <DataGridTextColumn Header="Name" Binding="{Binding Name}" Width="*"/>
                                <DataGridTextColumn Header="Type" Binding="{Binding Type}" Width="120"/>
                                <DataGridTextColumn Header="Size (MB)" Binding="{Binding Size}" Width="120"/>
                            </DataGrid.Columns>
                        </DataGrid>
                        <Button Name="btnDeleteFile" Grid.Row="3" Content="PERMANENTLY DELETE" Height="45" Background="#B71C1C" Foreground="White" Margin="0,15,0,0"/>
                    </Grid>
                </TabItem>

                <!-- TAB 4: NETWORK AUDIT -->
                <TabItem>
                    <Grid Margin="30">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="*"/> <RowDefinition Height="150"/> <RowDefinition Height="Auto"/> </Grid.RowDefinitions>

                        <StackPanel Grid.Row="0" Margin="0,0,0,20">
                            <TextBlock Text="Network Intelligence Audit" FontSize="26" FontWeight="ExtraBold" Foreground="White"/>
                            <TextBlock Text="Live TCP/UDP socket monitoring and interface diagnostics." Foreground="#666"/>
                        </StackPanel>

                        <Border Grid.Row="1" Background="#0D0D0F" CornerRadius="10" Padding="10" BorderBrush="#1A1A1D" BorderThickness="1">
                            <DataGrid Name="dgNetstat" AutoGenerateColumns="False" Background="Transparent" Foreground="#BBB" BorderThickness="0" IsReadOnly="True">
                                <DataGrid.Columns>
                                    <DataGridTextColumn Header="PROCESS" Binding="{Binding ProcessName}" Width="120">
                                        <DataGridTextColumn.ElementStyle>
                                            <Style TargetType="TextBlock">
                                                <Setter Property="ToolTip" Value="{Binding Path}"/> </Style>
                                        </DataGridTextColumn.ElementStyle>
                                    </DataGridTextColumn>
                                        <DataGridTextColumn Header="PROTOCOL" Binding="{Binding Protocol}" Width="120"/>
                                        <DataGridTextColumn Header="USER" Binding="{Binding User}" Width="100"/>
                                        <DataGridTextColumn Header="LOCAL PORT" Binding="{Binding LocalPort}" Width="80"/>
                                        <DataGridTextColumn Header="REMOTE IP" Binding="{Binding RemoteAddress}" Width="120"/>
                                        <DataGridTextColumn Header="HOSTNAME" Binding="{Binding Hostname}" Width="180"/>
                                        <DataGridTextColumn Header="STATE" Binding="{Binding State}" Width="100"/>
                                        <DataGridTextColumn Header="EXE PATH" Binding="{Binding Path}" Width="250"/>
                                </DataGrid.Columns>
                            </DataGrid>
                        </Border>

                        <TextBox Name="txtNetOutput" Grid.Row="2" Margin="0,15,0,0" IsReadOnly="True" Background="#050505" Foreground="#00FF00" FontFamily="Consolas" VerticalScrollBarVisibility="Auto" Padding="10" BorderBrush="#222"/>

                        <UniformGrid Grid.Row="3" Columns="4" Margin="0,15,0,0">
                            <Button Name="btnNetstat" Content="🔍 SCAN CONNECTIONS" Height="45" Margin="0,0,5,0" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                            <Button Name="btnIPConfig" Content="📋 INTERFACE DETAILS" Height="45" Margin="5,0,5,0" Background="#1A1A25" Foreground="White" BorderThickness="0"/>
                            <Button Name="btnRoutePrint" Content="🛤️ ROUTING TABLE" Height="45" Margin="5,0,5,0" Background="#1A1A25" Foreground="White" BorderThickness="0"/>
                            <Button Name="btnDNSFlush" Content="🧹 FLUSH DNS" Height="45" Margin="5,0,0,0" Background="#B71C1C" Foreground="White" BorderThickness="0"/>
                        </UniformGrid>
                    </Grid>
                </TabItem>

                <!-- TAB 5: SECURITY & INTERVENTION CENTER -->
                <TabItem>
                    <ScrollViewer VerticalScrollBarVisibility="Auto">
                        <StackPanel Margin="25">
                            <TextBlock Text="Security &amp; Threat Intervention Center" FontSize="26" FontWeight="ExtraBold" Foreground="White" Margin="0,0,0,5"/>
                            <TextBlock Text="Centralized security auditing, system containment, host displacement, and policy hardening controls." Foreground="#666" Margin="0,0,0,20"/>

                            <Grid Margin="0,0,0,20">
                                <Grid.ColumnDefinitions>
                                    <ColumnDefinition Width="1.2*"/>
                                    <ColumnDefinition Width="*"/>
                                </Grid.ColumnDefinitions>

                                <!-- LEFT: Critical Overrides & Active Displacement -->
                                <StackPanel Grid.Column="0" Margin="0,0,10,0">
                                    <TextBlock Text="🚨 ACTIVE CONTAINMENT &amp; HOST DISPLACEMENT" Foreground="#B71C1C" FontWeight="Bold" FontSize="12" Margin="0,0,0,10"/>
                                    
                                    <!-- Overlay Message Box -->
                                    <Border Background="#1A1111" Padding="20" CornerRadius="8" BorderBrush="#331111" BorderThickness="1" Margin="0,0,0,15">
                                        <StackPanel>
                                            <TextBlock Text="ADMINISTRATIVE OVERLAY MESSAGE" FontSize="10" Foreground="#888" Margin="0,0,0,5"/>
                                            <TextBox Name="txtCustomMsg" Text="SECURITY WARNING: Unauthorized activity detected. Your workstation is locked." 
                                                    Padding="8" Background="#111" Foreground="White" BorderBrush="#444" Margin="0,0,0,10"/>
                                            
                                            <Button Name="btnPanicMsg" Content="📢 BROADCAST OVERLAY MESSAGE TO USER SESSION" Height="40" 
                                                    Background="#B71C1C" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                            
                                            <UniformGrid Columns="2" Margin="0,10,0,0">
                                                <Button Name="btnBlockInput" Content="🔒 BLOCK INPUT (60s)" Height="45" Background="#E65100" Foreground="White" Margin="0,0,4,0" FontWeight="Bold" BorderThickness="0"/>
                                                <Button Name="btnBlackout" Content="🌑 SCREEN BLACKOUT (15s)" Height="45" Background="#212121" Foreground="White" Margin="4,0,0,0" FontWeight="Bold" BorderThickness="0"/>
                                            </UniformGrid>
                                        </StackPanel>
                                    </Border>

                                    <TextBlock Text="⚙️ POLICY HARDENING &amp; TOOL CONTROL" Foreground="#007ACC" FontWeight="Bold" FontSize="12" Margin="0,5,0,10"/>
                                    <Border Background="#121214" Padding="20" CornerRadius="8" BorderBrush="#1A1A25" BorderThickness="1">
                                        <StackPanel>
                                            <UniformGrid Columns="2">
                                                <Button Name="btnDisableTools" Content="🚫 BLOCK TASKMGR/CMD/REG" Height="42" Background="#4E342E" Foreground="White" Margin="0,0,4,0" FontWeight="Bold" BorderThickness="0"/>
                                                <Button Name="btnEnableTools" Content="✅ ALLOW TASKMGR/CMD/REG" Height="42" Background="#222" Foreground="#007ACC" Margin="4,0,0,0" FontWeight="Bold" BorderThickness="0"/>
                                            </UniformGrid>

                                            <UniformGrid Columns="3" Margin="0,10,0,0">
                                                <Button Name="btnLock" Content="🔒 LOCK STATION" Height="45" Background="#1E1E1E" Foreground="White" Margin="0,0,3,0" BorderThickness="0"/>
                                                <Button Name="btnLogoff" Content="🚪 FORCE LOGOFF" Height="45" Background="#BF360C" Foreground="White" Margin="3,0,3,0" FontWeight="Bold" BorderThickness="0"/>
                                                <Button Name="btnRestart" Content="⚡ FORCE RESTART" Height="45" Background="#B71C1C" Foreground="White" Margin="3,0,0,0" FontWeight="Bold" BorderThickness="0"/>
                                            </UniformGrid>

                                            <Button Name="btnBuzzer" Content="🔊 TRIGGER AUDIBLE BUZZER BEEP" Height="38" Background="#2E7D32" Foreground="White" Margin="0,10,0,0" FontWeight="Bold" BorderThickness="0"/>
                                        </StackPanel>
                                    </Border>
                                </StackPanel>

                                <!-- RIGHT: Security Posture Matrix & Account Controls -->
                                <StackPanel Grid.Column="1" Margin="10,0,0,0">
                                    <TextBlock Text="🛡️ SECURITY POSTURE MATRIX" Foreground="#007ACC" FontWeight="Bold" FontSize="12" Margin="0,0,0,10"/>
                                    
                                    <Border Background="#0D0D12" Padding="20" CornerRadius="8" BorderBrush="#1A1A25" BorderThickness="1" Margin="0,0,0,15">
                                        <StackPanel>
                                            <TextBlock Text="WINDOWS FIREWALL ENFORCEMENT" FontSize="10" Foreground="#888" Margin="0,0,0,8"/>
                                            <UniformGrid Columns="2" Margin="0,0,0,15">
                                                <Button Name="btnEnableAllFW" Content="🛡️ ENABLE ALL PROFILES" Height="36" Background="#2E7D32" Foreground="White" Margin="0,0,4,0" FontWeight="Bold" BorderThickness="0"/>
                                                <Button Name="btnDisableAllFW" Content="⚠️ DISABLE ALL PROFILES" Height="36" Background="#B71C1C" Foreground="White" Margin="4,0,0,0" BorderThickness="0"/>
                                            </UniformGrid>

                                            <TextBlock Text="DEFENDER REAL-TIME PROTECTION" FontSize="10" Foreground="#888" Margin="0,0,0,8"/>
                                            <UniformGrid Columns="2" Margin="0,0,0,15">
                                                <Button Name="btnEnableAV" Content="✅ ENABLE DEFENDER" Height="36" Background="#2E7D32" Foreground="White" Margin="0,0,4,0" FontWeight="Bold" BorderThickness="0"/>
                                                <Button Name="btnDisableAV" Content="🛑 DISABLE DEFENDER" Height="36" Background="#424242" Foreground="White" Margin="4,0,0,0" BorderThickness="0"/>
                                            </UniformGrid>

                                            <TextBlock Text="CONTAINMENT NETWORK ISOLATION" FontSize="10" Foreground="#888" Margin="0,0,0,8"/>
                                            <Button Name="btnIsolateHost" Content="🚨 ISOLATE HOST (BLOCK NET TRAFFIC)" Height="42" Background="#D32F2F" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                        </StackPanel>
                                    </Border>

                                    <TextBlock Text="👤 ACCOUNT &amp; CREDENTIAL HARDENING" Foreground="#00A2FF" FontWeight="Bold" FontSize="12" Margin="0,0,0,10"/>
                                    <Border Background="#0D0D12" Padding="20" CornerRadius="8" BorderBrush="#1A1A25" BorderThickness="1">
                                        <StackPanel>
                                            <UniformGrid Columns="2" Margin="0,0,0,10">
                                                <Button Name="btnDisableGuest" Content="🚫 DISABLE GUEST ACCOUNT" Height="38" Background="#1A1A25" Foreground="White" Margin="0,0,4,0" BorderThickness="0"/>
                                                <Button Name="btnAuditAdmins" Content="📋 AUDIT LOCAL ADMINS" Height="38" Background="#1A1A25" Foreground="White" Margin="4,0,0,0" BorderThickness="0"/>
                                            </UniformGrid>
                                            <Button Name="btnPurgeSessions" Content="🧹 DISCONNECT ALL DISCONNECTED SESSIONS" Height="38" Background="#333333" Foreground="White" BorderThickness="0"/>
                                        </StackPanel>
                                    </Border>
                                </StackPanel>
                            </Grid>

                            <!-- PRESET SECURITY INCIDENT COMMAND LIBRARY -->
                            <TextBlock Text="💡 INCIDENT RESPONSE COMMAND QUICK-RUNNER" Foreground="#00A2FF" FontWeight="Bold" FontSize="14" Margin="0,10,0,10"/>
                            <Border Background="#0A0A10" Padding="15" CornerRadius="8" BorderBrush="#1A1A25" BorderThickness="1">
                                <UniformGrid Columns="2">
                                    
                                    <!-- Action 1 -->
                                    <Border Background="#121218" CornerRadius="5" Padding="10" Margin="4" BorderBrush="#222" BorderThickness="1">
                                        <DockPanel>
                                            <StackPanel DockPanel.Dock="Left" Width="300">
                                                <TextBlock Text="Disable SMBv1 Vulnerable Protocol" FontWeight="Bold" Foreground="White"/>
                                                <TextBlock Text="Set-SmbServerConfiguration -EnableSMB1Protocol $false" FontFamily="Consolas" FontSize="9" Foreground="#00FF00" Margin="0,4,0,0"/>
                                            </StackPanel>
                                            <Button Name="btnRunSecSMB" Content="RUN ACTION" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0" Height="32" Width="90" HorizontalAlignment="Right"/>
                                        </DockPanel>
                                    </Border>

                                    <!-- Action 2 -->
                                    <Border Background="#121218" CornerRadius="5" Padding="10" Margin="4" BorderBrush="#222" BorderThickness="1">
                                        <DockPanel>
                                            <StackPanel DockPanel.Dock="Left" Width="300">
                                                <TextBlock Text="Flush ARP Network Table" FontWeight="Bold" Foreground="White"/>
                                                <TextBlock Text="netsh interface ip delete arpcache" FontFamily="Consolas" FontSize="9" Foreground="#00FF00" Margin="0,4,0,0"/>
                                            </StackPanel>
                                            <Button Name="btnRunSecARP" Content="RUN ACTION" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0" Height="32" Width="90" HorizontalAlignment="Right"/>
                                        </DockPanel>
                                    </Border>

                                    <!-- Action 3 -->
                                    <Border Background="#121218" CornerRadius="5" Padding="10" Margin="4" BorderBrush="#222" BorderThickness="1">
                                        <DockPanel>
                                            <StackPanel DockPanel.Dock="Left" Width="300">
                                                <TextBlock Text="Purge Kerberos Credential Tickets" FontWeight="Bold" Foreground="White"/>
                                                <TextBlock Text="klist purge" FontFamily="Consolas" FontSize="9" Foreground="#00FF00" Margin="0,4,0,0"/>
                                            </StackPanel>
                                            <Button Name="btnRunSecKlist" Content="RUN ACTION" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0" Height="32" Width="90" HorizontalAlignment="Right"/>
                                        </DockPanel>
                                    </Border>

                                    <!-- Action 4 -->
                                    <Border Background="#121218" CornerRadius="5" Padding="10" Margin="4" BorderBrush="#222" BorderThickness="1">
                                        <DockPanel>
                                            <StackPanel DockPanel.Dock="Left" Width="300">
                                                <TextBlock Text="Reset WinSock &amp; TCP/IP Stack" FontWeight="Bold" Foreground="White"/>
                                                <TextBlock Text="netsh winsock reset" FontFamily="Consolas" FontSize="9" Foreground="#00FF00" Margin="0,4,0,0"/>
                                            </StackPanel>
                                            <Button Name="btnRunSecWinsock" Content="RUN ACTION" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0" Height="32" Width="90" HorizontalAlignment="Right"/>
                                        </DockPanel>
                                    </Border>

                                </UniformGrid>
                            </Border>

                        </StackPanel>
                    </ScrollViewer>
                </TabItem>

                <!-- TAB 6: TASK SCHEDULER -->
                <TabItem>
                    <Grid Margin="20">
                        <Grid.ColumnDefinitions>
                            <ColumnDefinition Width="*"/>
                            <ColumnDefinition Width="480"/>
                        </Grid.ColumnDefinitions>

                        <!-- LEFT COLUMN: Task Registration & DataGrid -->
                        <Grid Grid.Column="0" Margin="0,0,15,0">
                            <Grid.RowDefinitions>
                                <RowDefinition Height="Auto"/>
                                <RowDefinition Height="Auto"/>
                                <RowDefinition Height="*"/>
                                <RowDefinition Height="Auto"/>
                            </Grid.RowDefinitions>

                            <TextBlock Text="Task Scheduler Operations" FontSize="24" FontWeight="Bold" Foreground="White" Grid.Row="0" Margin="0,0,0,15"/>

                            <!-- Creation Form Panel -->
                            <Border Grid.Row="1" Background="#0A0A10" Padding="15" CornerRadius="8" Margin="0,0,0,15" BorderBrush="#1A1A25" BorderThickness="1">
                                <Grid>
                                    <Grid.ColumnDefinitions>
                                        <ColumnDefinition Width="*"/>
                                        <ColumnDefinition Width="*"/>
                                    </Grid.ColumnDefinitions>
                                    <StackPanel Grid.Column="0" Margin="0,0,8,0">
                                        <TextBlock Text="TASK NAME" FontSize="10" Foreground="#00A2FF" Margin="0,0,0,4"/>
                                        <TextBox Name="txtSchedName" Text="NightlyShutdown" Padding="6" Background="#15151A" Foreground="White" BorderThickness="1" BorderBrush="#333"/>
                                        <TextBlock Text="EXECUTABLE / COMMAND" FontSize="10" Foreground="#00A2FF" Margin="0,8,0,4"/>
                                        <TextBox Name="txtSchedPath" Text="shutdown.exe" Padding="6" Background="#15151A" Foreground="White" BorderThickness="1" BorderBrush="#333"/>
                                    </StackPanel>
                                    <StackPanel Grid.Column="1" Margin="8,0,0,0">
                                        <TextBlock Text="ARGUMENTS" FontSize="10" Foreground="#00A2FF" Margin="0,0,0,4"/>
                                        <TextBox Name="txtSchedArgs" Text="/s /f /t 60" Padding="6" Background="#15151A" Foreground="White" BorderThickness="1" BorderBrush="#333"/>
                                        <TextBlock Text="EXECUTION TRIGGER" FontSize="10" Foreground="#00A2FF" Margin="0,8,0,4"/>
                                        <ComboBox Name="cmbSchedTrigger" Height="28" Background="#15151A" Foreground="White" BorderThickness="1" BorderBrush="#333" SelectedIndex="0">
                                            <ComboBoxItem Content="Daily (Midnight 00:00)"/>
                                            <ComboBoxItem Content="At System Boot (AtStartup)"/>
                                            <ComboBoxItem Content="At User Logon (AtLogOn)"/>
                                            <ComboBoxItem Content="Hourly Repeat"/>
                                        </ComboBox>
                                        <Button Name="btnCreateTask" Content="⚡ REGISTER TASK ON REMOTE HOST" Height="34" Margin="0,12,0,0" Background="#2E7D32" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                    </StackPanel>
                                </Grid>
                            </Border>

                            <!-- DataGrid -->
                            <DataGrid Name="dgTasks" Grid.Row="2" AutoGenerateColumns="False" IsReadOnly="True" SelectionMode="Single">
                                <DataGrid.Columns>
                                    <DataGridTextColumn Header="TASK NAME" Binding="{Binding Name}" Width="170"/>
                                    <DataGridTextColumn Header="STATE" Binding="{Binding State}" Width="80"/>
                                    <DataGridTextColumn Header="LAST RESULT" Binding="{Binding LastResult}" Width="90"/>
                                    <DataGridTextColumn Header="AUTHOR" Binding="{Binding Author}" Width="*"/>
                                </DataGrid.Columns>
                            </DataGrid>

                            <!-- Controls Toolbar -->
                            <UniformGrid Grid.Row="3" Columns="6" Margin="0,10,0,0">
                                <Button Name="btnSchedRefresh" Content="🔄 REFRESH" Height="38" Margin="0,0,2,0" Background="#1A1A25" Foreground="White" BorderThickness="0"/>
                                <Button Name="btnSchedStart"   Content="▶️ RUN"     Height="38" Margin="2,0,2,0" Background="#0D47A1" Foreground="White" BorderThickness="0"/>
                                <Button Name="btnSchedStop"    Content="⏹️ STOP"    Height="38" Margin="2,0,2,0" Background="#B71C1C" Foreground="White" BorderThickness="0"/>
                                <Button Name="btnSchedEnable"  Content="🔓 ENABLE"  Height="38" Margin="2,0,2,0" Background="#2E7D32" Foreground="White" BorderThickness="0"/>
                                <Button Name="btnSchedDisable" Content="🔒 DISABLE" Height="38" Margin="2,0,2,0" Background="#424242" Foreground="White" BorderThickness="0"/>
                                <Button Name="btnSchedDelete"  Content="🗑️ DELETE"  Height="38" Margin="2,0,0,0" Background="#D32F2F" Foreground="White" BorderThickness="0"/>
                            </UniformGrid>
                        </Grid>

                        <!-- RIGHT COLUMN: Interactive Preset Library & Hint Documentation -->
                        <Border Grid.Column="1" Background="#0C0C10" Padding="15" CornerRadius="8" BorderBrush="#1A1A25" BorderThickness="1">
                            <Grid>
                                <Grid.RowDefinitions>
                                    <RowDefinition Height="Auto"/>
                                    <RowDefinition Height="Auto"/>
                                    <RowDefinition Height="*"/>
                                </Grid.RowDefinitions>

                                <StackPanel Grid.Row="0" Margin="0,0,0,10">
                                    <TextBlock Text="💡 Preset Library &amp; Snippet Guides" FontSize="18" FontWeight="Bold" Foreground="#00A2FF"/>
                                    <TextBlock Text="Click 'USE PRESET' to populate the form or 'COPY CMD' to copy raw syntax." FontSize="10" Foreground="#888" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                </StackPanel>

                                <!-- Live Filter Box -->
                                <Border Grid.Row="1" Background="#121218" CornerRadius="4" Padding="8,4" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                    <DockPanel>
                                        <TextBlock Text="🔍 SEARCH PRESETS:" VerticalAlignment="Center" Foreground="#00A2FF" FontSize="10" FontWeight="Bold" Margin="0,0,8,0"/>
                                        <TextBox Name="txtPresetFilter" Background="Transparent" Foreground="White" BorderThickness="0" CaretBrush="White"/>
                                    </DockPanel>
                                </Border>

                                <!-- Scrollable Preset Collection -->
                                <ScrollViewer Grid.Row="2" VerticalScrollBarVisibility="Auto">
                                    <StackPanel Name="pnlPresetList">

                                        <!-- PRESET 1 -->
                                        <Border Tag="shutdown nightly midnight maintenance restart" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="🌙 Daily Nightly Shutdown (00:00)" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset1" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetShutdown" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: shutdown.exe /s /f /t 60" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Triggers daily forced system shutdown at midnight with 60s prompt." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 2 -->
                                        <Border Tag="weekly reboot sunday restart maintenance" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="🔄 Weekly Reboot (Sun 03:00 AM)" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset2" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetReboot" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: shutdown.exe /r /f /t 30" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Schedules forced reboot every Sunday morning for maintenance." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 3 -->
                                        <Border Tag="clean temp temporary files purge disk garbage" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="🧹 Daily Temp Cleanup (Files > 7 Days)" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset3" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetCleanTemp" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: powershell.exe Get-ChildItem $env:TEMP..." FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Deletes files older than 7 days from the system temp directory daily." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 4 -->
                                        <Border Tag="backup registry hklm reg export hive" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="💾 Daily Registry Export (01:00 AM)" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset4" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetBackupReg" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: reg.exe export HKLM\SOFTWARE..." FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Exports system Software registry hive to local disk every night." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 5 -->
                                        <Border Tag="log boot startup audit append timestamp" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="📜 Startup Boot Timestamp Logging" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset5" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetLogBoot" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: powershell.exe Add-Content..." FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Appends boot timestamp to C:\Logs\BootHistory.log on startup." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 6 -->
                                        <Border Tag="flush dns cache network reset ip" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="🌐 Daily DNS Resolver Cache Flush" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset6" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetFlushDNS" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: ipconfig.exe /flushdns" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Flushes system DNS resolver cache every morning at 06:00 AM." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 7 -->
                                        <Border Tag="defender antivirus quick scan security update" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="🛡️ Daily Defender Quick Scan (12:00 PM)" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset7" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetDefScan" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: MpCmdRun.exe -Scan -ScanType 1" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Triggers Microsoft Defender Quick Scan daily at noon." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 8 -->
                                        <Border Tag="firewall enable block security policy profile" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="🔒 Firewall Audit Enforcement" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset8" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetEnforceFW" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: netsh.exe advfirewall set allprofiles state on" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Re-enables all firewall profiles every hour to prevent tampering." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 9 -->
                                        <Border Tag="defrag disk optimize drive storage c:" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="💿 Weekly Disk Optimization (Drive C:)" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset9" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetDefrag" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: defrag.exe C: /O" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Performs storage TRIM/defragmentation on drive C: weekly." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 10 -->
                                        <Border Tag="kill unresponsive frozen processes taskkill" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="⚙️ Auto-Terminate Frozen Applications" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset10" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetKillHung" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: taskkill.exe /F /FI &quot;STATUS eq NOT RESPONDING&quot;" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Scans and kills all non-responsive process threads every 2 hours." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 11 -->
                                        <Border Tag="user logon initial logon trigger script" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,10" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="👤 User Logon Session Initialization" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset11" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetLogonInit" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: powershell.exe -File &quot;C:\Scripts\UserInit.ps1&quot;" FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Executes background user environment setup script upon logon." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- PRESET 12 -->
                                        <Border Tag="system health status audit log report" Background="#121218" CornerRadius="5" Padding="10" Margin="0,0,0,15" BorderBrush="#222" BorderThickness="1">
                                            <StackPanel>
                                                <Grid>
                                                    <TextBlock Text="📊 System Diagnostic Telemetry Dump" FontWeight="Bold" Foreground="White"/>
                                                    <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                                        <Button Name="btnCopyPreset12" Content="COPY CMD" Padding="6,2" FontSize="9" Background="#222" Foreground="#BBB" Margin="0,0,4,0" BorderThickness="0"/>
                                                        <Button Name="btnPresetSysReport" Content="USE PRESET" Padding="8,2" FontSize="9" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                                                    </StackPanel>
                                                </Grid>
                                                <TextBlock Text="Cmd: powershell.exe Get-ComputerInfo..." FontFamily="Consolas" FontSize="10" Foreground="#2ECC71" Margin="0,5,0,0"/>
                                                <TextBlock Text="Generates system diagnostic inventory report every Monday morning." FontSize="10" Foreground="#777" Margin="0,2,0,0" TextWrapping="Wrap"/>
                                            </StackPanel>
                                        </Border>

                                        <!-- REFERENCE CHEAT SHEET -->
                                        <TextBlock Text="📖 PowerShell Task Syntax Guide" FontSize="13" FontWeight="Bold" Foreground="White" Margin="0,5,0,5"/>
                                        <Border Background="#050508" Padding="10" CornerRadius="5" BorderBrush="#111" BorderThickness="1">
                                            <StackPanel>
                                                <TextBlock Text="# Register Command Structure:" Foreground="#888" FontSize="9" FontFamily="Consolas"/>
                                                <TextBox Text="Register-ScheduledTask -TaskName 'NightlyShutdown' `&#10;  -Trigger (New-ScheduledTaskTrigger -Daily -At 00:00) `&#10;  -Action (New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '/s /f /t 60') `&#10;  -User 'NT AUTHORITY\SYSTEM' `&#10;  -RunLevel Highest -Force" FontFamily="Consolas" FontSize="9.5" Foreground="#00FF00" Background="Transparent" BorderThickness="0" IsReadOnly="True" TextWrapping="Wrap"/>
                                                <Separator Background="#222" Margin="0,8"/>
                                                <TextBlock Text="# Essential PowerShell Operators:" Foreground="#888" FontSize="9" FontFamily="Consolas"/>
                                                <TextBlock Text="• Start: Start-ScheduledTask -TaskName 'Name'&#10;• Stop:  Stop-ScheduledTask -TaskName 'Name'&#10;• Delete: Unregister-ScheduledTask -TaskName 'Name' -Confirm:$false&#10;• Query: Get-ScheduledTaskInfo -TaskName 'Name'" Foreground="#BBB" FontSize="9.5" FontFamily="Consolas" Margin="0,4,0,0"/>
                                            </StackPanel>
                                        </Border>

                                    </StackPanel>
                                </ScrollViewer>
                            </Grid>
                        </Border>
                    </Grid>
                </TabItem>

                <!-- TAB 7: SERVICES -->
                <TabItem>
                    <Grid Margin="30">
                        <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="*"/><RowDefinition Height="Auto"/></Grid.RowDefinitions>
                        <TextBlock Text="System Services" FontSize="24" FontWeight="Bold" Margin="0,0,0,20"/>
                        <DataGrid Name="dgServices" Grid.Row="1" AutoGenerateColumns="False">
                            <DataGrid.Columns>
                                <DataGridTextColumn Header="Name" Binding="{Binding Name}" Width="200"/>
                                <DataGridTextColumn Header="Display Name" Binding="{Binding Display}" Width="*"/>
                                <DataGridTextColumn Header="Status" Binding="{Binding Status}" Width="120"/>
                            </DataGrid.Columns>
                        </DataGrid>
                        <UniformGrid Grid.Row="2" Columns="3" Margin="0,15,0,0">
                            <Button Name="btnSvcStart" Content="START" Height="45" Background="#2E7D32" Foreground="White" Margin="0,0,5,0"/>
                            <Button Name="btnSvcStop" Content="STOP" Height="45" Background="#B71C1C" Foreground="White" Margin="5,0,5,0"/>
                            <Button Name="btnSvcRefresh" Content="REFRESH" Height="45" Margin="5,0,0,0"/>
                        </UniformGrid>
                    </Grid>
                </TabItem>

                <!-- TAB 8: CONSOLE -->
                <TabItem>
                    <Grid Margin="30">
                        <Grid.RowDefinitions><RowDefinition Height="Auto"/><RowDefinition Height="200"/><RowDefinition Height="Auto"/><RowDefinition Height="*"/></Grid.RowDefinitions>
                        <TextBlock Text="PowerShell Console" FontSize="24" FontWeight="Bold" Margin="0,0,0,20"/>
                        <TextBox Name="txtCommand" Grid.Row="1" Background="#1E1E1E" Foreground="#2ECC71" FontFamily="Consolas" AcceptsReturn="True" VerticalScrollBarVisibility="Auto" Padding="10"/>
                        <Button Name="btnRunShell" Grid.Row="2" Content="EXECUTE SCRIPT" Height="40" Background="#007ACC" Foreground="White" Margin="0,15"/>
                        <TextBox Name="txtOutput" Grid.Row="3" IsReadOnly="True" Background="#050505" Foreground="#DCDCDC" FontFamily="Consolas" VerticalScrollBarVisibility="Auto" Padding="10"/>
                    </Grid>
                </TabItem>

                <!-- TAB 9: CONFIG -->
                <TabItem>
                    <StackPanel Margin="100,50">
                        <TextBlock Text="Remote Authentication Config" FontSize="24" FontWeight="Bold" Margin="0,0,0,30"/>
                        <TextBlock Text="Target IP / Hostname"/><TextBox Name="txtHost" Text="remote_host" Margin="0,5,0,20" Padding="12" Background="#111114" Foreground="White"/>
                        <TextBlock Text="Admin Username"/><TextBox Name="txtUser" Text="remote_user" Margin="0,5,0,20" Padding="12" Background="#111114" Foreground="White"/>
                        <TextBlock Text="Access Password"/><PasswordBox Name="txtPass" Margin="0,5,0,30" Padding="12" Background="#111114" Foreground="White"/>
                    </StackPanel>
                </TabItem>
                
                <!-- TAB 10: REMOTE VIEW -->
                <TabItem>
                    <Grid Margin="30">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        
                        <StackPanel Grid.Row="0" Margin="0,0,0,20">
                            <TextBlock Text="Live Screen Capture" FontSize="28" FontWeight="ExtraBold" Foreground="White"/>
                            <TextBlock Text="Visualizes the active user's desktop session via GDI+ capture." Foreground="#666"/>
                        </StackPanel>

                        <Border Grid.Row="1" Background="#050505" BorderBrush="#1A1A1D" BorderThickness="1" CornerRadius="10" Padding="5">
                            <Image Name="imgScreenshot" Stretch="Uniform" RenderOptions.BitmapScalingMode="HighQuality">
                                <Image.Effect>
                                    <DropShadowEffect BlurRadius="15" ShadowDepth="0" Color="Black" Opacity="0.5"/>
                                </Image.Effect>
                            </Image>
                        </Border>

                        <Button Name="btnTakeScreenshot" Grid.Row="2" Content="GENERATE REMOTE SCREENSHOT" 
                                Height="50" Margin="0,20,0,0" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                    </Grid>
                </TabItem>

                <!-- TAB 11: SOFTWARE AUDIT -->
                <TabItem Header="📦 Software Audit">
                    <Grid Margin="30">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/>
                            <RowDefinition Height="*"/>
                            <RowDefinition Height="Auto"/>
                        </Grid.RowDefinitions>
                        
                        <StackPanel Grid.Row="0" Margin="0,0,0,20">
                            <TextBlock Text="Software &amp; Package Inventory" FontSize="28" FontWeight="ExtraBold" Foreground="White"/>
                            <TextBlock Text="Comprehensive audit of Win32 Apps, Appx Packages, and System Features." Foreground="#666"/>
                        </StackPanel>

                        <Border Grid.Row="1" Background="#0D0D0F" CornerRadius="10" Padding="10" BorderBrush="#1A1A1D" BorderThickness="1">
                            <DataGrid Name="dgSoftware" AutoGenerateColumns="False" Background="Transparent" Foreground="#BBB" BorderThickness="0" IsReadOnly="True" SelectionMode="Single">
                                <DataGrid.Columns>
                                    <DataGridTextColumn Header="STATUS" Binding="{Binding Status}" Width="85">
                                        <DataGridTextColumn.ElementStyle>
                                            <Style TargetType="TextBlock">
                                                <Style.Triggers>
                                                    <DataTrigger Binding="{Binding Status}" Value="ACTIVE">
                                                        <Setter Property="Foreground" Value="#00FF00"/>
                                                        <Setter Property="FontWeight" Value="Bold"/>
                                                    </DataTrigger>
                                                    <DataTrigger Binding="{Binding Status}" Value="Idle">
                                                        <Setter Property="Foreground" Value="#666"/>
                                                    </DataTrigger>
                                                </Style.Triggers>
                                            </Style>
                                        </DataGridTextColumn.ElementStyle>
                                    </DataGridTextColumn>

                                    <DataGridTextColumn Header="APPLICATION NAME" Binding="{Binding Name}" Width="*"/>
                                    <DataGridTextColumn Header="VERSION" Binding="{Binding Version}" Width="100"/>
                                    <DataGridTextColumn Header="PUBLISHER" Binding="{Binding Publisher}" Width="120"/>
                                    <DataGridTextColumn Header="ARCH" Binding="{Binding Arch}" Width="60"/>
                                    <DataGridTextColumn Header="SOURCE" Binding="{Binding Source}" Width="70"/>
                                    <DataGridTextColumn Header="INSTALL DATE" Binding="{Binding InstallDate}" Width="100"/>
                                </DataGrid.Columns>
                            </DataGrid>
                        </Border>

                        <UniformGrid Grid.Row="2" Columns="4" Margin="0,15,0,0">
                            <Button Name="btnScanSoftware" Content="🔍 FULL INVENTORY SCAN" Height="50" Background="#007ACC" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                            <Button Name="btnListUpdates" Content="🛡️ VIEW PENDING UPDATES" Height="50" Margin="10,0" Background="#1A1A25" Foreground="White" BorderThickness="0"/>
                            <Button Name="btnGetFeatures" Content="⚙️ WINDOWS FEATURES" Height="50" Margin="0,0,10,0" Background="#1A1A25" Foreground="White" BorderThickness="0"/>
                            <Button Name="btnUninstallApp" Content="❌ UNINSTALL SELECTED" Height="50" Background="#B71C1C" Foreground="White" FontWeight="Bold" BorderThickness="0"/>
                        </UniformGrid>
                    </Grid>
                </TabItem>

                <!-- TAB 12: DRIVER MANAGER -->
                <TabItem Header="🔌 Driver Manager">
                    <Grid Margin="30">
                        <Grid.RowDefinitions>
                            <RowDefinition Height="Auto"/> <RowDefinition Height="*"/>    <RowDefinition Height="Auto"/> </Grid.RowDefinitions>

                        <StackPanel Grid.Row="0" Margin="0,0,0,15">
                            <TextBlock Text="Hardware &amp; Driver Audit" FontSize="26" FontWeight="Bold" Foreground="White"/>
                            <DockPanel Margin="0,5,0,0">
                                <TextBlock Text="Complete inventory of PnP devices." Foreground="#666"/>
                                <StackPanel Orientation="Horizontal" HorizontalAlignment="Right">
                                    <TextBlock Text="🔍 FILTER:" VerticalAlignment="Center" Margin="0,0,10,0" Foreground="#007ACC" FontSize="10"/>
                                    <TextBox Name="txtDriverFilter" Width="200" Background="#111" Foreground="White" BorderBrush="#333" Padding="4"/>
                                </StackPanel>
                            </DockPanel>
                        </StackPanel>

                        <Border Grid.Row="1" Background="#0D0D0F" CornerRadius="8" BorderBrush="#1A1A1D" BorderThickness="1">
                            <DataGrid Name="dgDrivers" AutoGenerateColumns="False" Background="Transparent" 
                                    Foreground="#BBB" BorderThickness="0" IsReadOnly="True" 
                                    SelectionMode="Single" VerticalScrollBarVisibility="Auto">
                                <DataGrid.Columns>
                                    <DataGridTextColumn Header="CLASS" Binding="{Binding Class}" Width="120"/>
                                    <DataGridTextColumn Header="DEVICE NAME" Binding="{Binding FriendlyName}" Width="*"/>
                                    <DataGridTextColumn Header="STATUS" Binding="{Binding Status}" Width="80"/>
                                    <DataGridTextColumn Header="VERSION" Binding="{Binding DriverVersion}" Width="120"/>
                                    <DataGridTextColumn Header="INSTANCE ID" Binding="{Binding InstanceId}" Visibility="Collapsed"/>
                                </DataGrid.Columns>
                            </DataGrid>
                        </Border>
                        
                        <UniformGrid Grid.Row="2" Columns="4" Margin="0,15,0,0" Height="45">
                            <Button Name="btnScanDrivers" Content="🔍 FULL SCAN" Background="#007ACC" Foreground="White" FontWeight="Bold"/>
                            <Button Name="btnDriverProps" Content="📄 PROPERTIES" Margin="10,0" Background="#1A1A25" Foreground="White"/>
                            <Button Name="btnRestartDevice" Content="🔄 RESTART DEVICE" Margin="0,0,10,0" Background="#1A1A25" Foreground="White"/>
                            <Button Name="btnUninstallDriver" Content="❌ UNINSTALL" Background="#B71C1C" Foreground="White" FontWeight="Bold"/>
                        </UniformGrid>
                    </Grid>
                </TabItem>
                
            </TabControl>
        </DockPanel>
    </Grid>
</Window>
"@

$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)
$xaml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $window.FindName($_.Name) -Scope Global }

function Get-Cred { 
    $sec = ConvertTo-SecureString $txtPass.Password -AsPlainText -Force
    return New-Object System.Management.Automation.PSCredential($txtUser.Text, $sec) 
}

function Invoke-RExec ($SB, $Param) {
    try {
        $mainStatus.Text = "Connecting to $($txtHost.Text)..."
        $res = Invoke-Command -ComputerName $txtHost.Text -Credential (Get-Cred) -ScriptBlock $SB -ArgumentList $Param -ErrorAction Stop
        $mainStatus.Text = "Ready."
        $statusDot.Fill = "#2ECC71"
        return $res
    }
    catch {
        if ($_.Exception.Message -like "*TrustedHosts*") {
            if (Add-ToTrustedHosts -IP $txtHost.Text) {
                return Invoke-RExec $SB $Param 
            }
        }
        $mainStatus.Text = "Connection Failed: $($_.Exception.Message)"
        $statusDot.Fill = "#FF5555"
        return $null
    }
}

function Add-ToTrustedHosts {
    param ([string]$IP)
    $current = (Get-Item WSMan:\localhost\Client\TrustedHosts).Value
    if ($current -split ',' -contains $IP -or $current -eq '*') { return $true }
    $msg = "The host '$IP' is not in your TrustedHosts list. WinRM requires this for non-domain connections.`n`nDo you want to add it automatically?"
    $confirm = [System.Windows.MessageBox]::Show($msg, "Security Authorization", 'YesNo', 'Warning')
    if ($confirm -eq 'Yes') {
        try {
            $newVal = if ([string]::IsNullOrWhiteSpace($current)) { $IP } else { "$current,$IP" }
            Set-Item WSMan:\localhost\Client\TrustedHosts -Value $newVal -Force -Confirm:$false
            $mainStatus.Text = "Added $IP to Trusted Hosts."
            return $true
        }
        catch {
            [System.Windows.MessageBox]::Show("Failed to update TrustedHosts. Please run PowerShell as Administrator.", "Access Denied")
            return $false
        }
    }
    return $false
}

function Get-ActualPing {
    param([string]$Hostname)
    try {
        $ping = New-Object System.Net.NetworkInformation.Ping
        $reply = $ping.Send($Hostname, 1000)
        if ($reply.Status -eq "Success") {
            return $reply.RoundtripTime
        }
    }
    catch { }
    try {
        $tcpClient = New-Object System.Net.Sockets.TcpClient
        $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
        $asyncResult = $tcpClient.BeginConnect($Hostname, 5985, $null, $null)
        $waitResult = $asyncResult.AsyncWaitHandle.WaitOne(1000, $false)
        $stopwatch.Stop()
        if ($waitResult -and $tcpClient.Connected) {
            $tcpClient.EndConnect($asyncResult)
            $tcpClient.Close()
            return [math]::Max(1, [int]$stopwatch.ElapsedMilliseconds)
        }
        $tcpClient.Close()
    }
    catch { }
    return -1
}

$nodes = @(
    "lblNodeName", "lblNodeIP", "dashCPU", "pbCPU", "dashRAM", "pbRAM", 
    "dashDisk", "pbDisk", "dashPing", "stFW", "stAV", "stBit", 
    "stGW", "stDNS", "stUser", "stLogon", "stIdle", "dgEvents", "txtStatus", "elStatus",
    "cntCritical", "cntSecurity", "cntDisk", "cntApp", "txtEventFilter",
    "navScreen", "imgScreenshot", "btnTakeScreenshot",
    "dgNetstat", "btnNetstat", "btnIPConfig", "btnRoutePrint", "btnDNSFlush",
    "dgSoftware", "btnScanSoftware", "btnListUpdates", "btnGetFeatures", "btnUninstallApp",
    "dgDrivers", "txtDriverFilter", "btnScanDrivers",
    "dgProcesses", "txtProcFilter", "btnRefreshProc", "btnKill", "btnUninstallDriver",
    "btnDriverProps", "btnRestartDevice",
    "cmbSchedTrigger", "txtPresetFilter", "pnlPresetList",
    "btnPresetShutdown", "btnPresetReboot", "btnPresetCleanTemp", "btnPresetBackupReg", "btnPresetLogBoot",
    "btnPresetFlushDNS", "btnPresetDefScan", "btnPresetEnforceFW", "btnPresetDefrag", "btnPresetKillHung",
    "btnPresetLogonInit", "btnPresetSysReport",
    "btnCopyPreset1", "btnCopyPreset2", "btnCopyPreset3", "btnCopyPreset4", "btnCopyPreset5", "btnCopyPreset6",
    "btnCopyPreset7", "btnCopyPreset8", "btnCopyPreset9", "btnCopyPreset10", "btnCopyPreset11", "btnCopyPreset12",
    "btnEnableAllFW", "btnDisableAllFW", "btnEnableAV", "btnDisableAV", "btnIsolateHost",
    "btnDisableGuest", "btnAuditAdmins", "btnPurgeSessions",
    "btnRunSecSMB", "btnRunSecARP", "btnRunSecKlist", "btnRunSecWinsock"
)

foreach ($node in $nodes) {
    Set-Variable -Name $node -Value $window.FindName($node) -Scope Global
}

$navDash.Add_Click({ $MainTabs.SelectedIndex = 0 })
$navEvents.Add_Click({ $MainTabs.SelectedIndex = 1 })
$navProc.Add_Click({ $MainTabs.SelectedIndex = 2 })
$navFile.Add_Click({ $MainTabs.SelectedIndex = 3 })
$navNet.Add_Click({ $MainTabs.SelectedIndex = 4 })
$navSec.Add_Click({ $MainTabs.SelectedIndex = 5 })
$navSched.Add_Click({ $MainTabs.SelectedIndex = 6 })
$navSvc.Add_Click({ $MainTabs.SelectedIndex = 7 })
$navCons.Add_Click({ $MainTabs.SelectedIndex = 8 })
$navConfig.Add_Click({ $MainTabs.SelectedIndex = 9 })
$navScreen.Add_Click({ $MainTabs.SelectedIndex = 10 })
$navSoftware.Add_Click({ $MainTabs.SelectedIndex = 11 })
$navDrivers.Add_Click({ $MainTabs.SelectedIndex = 12 })

$btnGlobalSync.Add_Click({
        $target = $txtHost.Text
        if ([string]::IsNullOrWhitespace($target)) { return }
        $mainStatus.Foreground = [System.Windows.Media.Brushes]::White
        $statusDot.Fill = [System.Windows.Media.Brushes]::Orange
        $elStatus.Fill = [System.Windows.Media.Brushes]::Orange
        $txtStatus.Text = "CONNECTING..."
        [System.Windows.Forms.Application]::DoEvents()
        $mainStatus.Text = "📡 Step 1/3: Pinging $target..."
        [System.Windows.Forms.Application]::DoEvents()
        $ms = Get-ActualPing -Hostname $target
        if ($ms -ge 0) {
            $latency = $ms
            $dashPing.Text = "$ms ms"
            $dashPing.Foreground = if ($ms -lt 100) { [System.Windows.Media.Brushes]::LightGreen } else { [System.Windows.Media.Brushes]::Orange }
            $mainStatus.Text = "📡 Step 1 Success ($ms ms). Authenticating..."
        }
        else {
            $latency = 999
            $dashPing.Text = "TIMEOUT"
            $dashPing.Foreground = [System.Windows.Media.Brushes]::Red
            $mainStatus.Text = "⚠️ Step 1: Timeout. Attempting WinRM anyway..."
        }
        [System.Windows.Forms.Application]::DoEvents()
        $lblGlobalHost.Text = "CONNECTING: $target..."
        $lblGlobalHost.Foreground = [System.Windows.Media.Brushes]::Orange
        $mainStatus.Text = "🚀 Step 3/3: Establishing WinRM Session & Fetching Data..."
        $txtStatus.Text = "POLLING..."
        [System.Windows.Forms.Application]::DoEvents()
        $data = Invoke-RExec {
            try {
                $comp = Get-CimInstance Win32_OperatingSystem -ErrorAction Stop
                $uptimeSpan = (Get-Date) - $comp.LastBootUpTime
                $cpu = Get-CimInstance Win32_Processor
                $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
                $net = Get-NetIPConfiguration | Where-Object { $_.IPv4Address -ne $null } | Select-Object -First 1
                $mp = Get-MpComputerStatus
                $bit = Get-BitLockerVolume -MountPoint "C:" -ErrorAction SilentlyContinue
                $u = "None"; $l = "N/A"; $i = "N/A"
                $q = quser 2>$null
                if ($q) { $f = $q[1] -split '\s+'; $u = $f[1]; $l = "$($f[5]) $($f[6])"; $i = $f[7] }
                $sysLogs = Get-WinEvent -FilterHashtable @{LogName = 'System'; Level = 1, 2; StartTime = (Get-Date).AddDays(-1) } -ErrorAction SilentlyContinue
                $secLogs = Get-WinEvent -FilterHashtable @{LogName = 'Security'; Id = 4625; StartTime = (Get-Date).AddDays(-1) } -ErrorAction SilentlyContinue
                $diskLogs = Get-WinEvent -FilterHashtable @{LogName = 'System'; ProviderName = 'Disk'; StartTime = (Get-Date).AddDays(-7) } -ErrorAction SilentlyContinue
                $appLogs = Get-WinEvent -FilterHashtable @{LogName = 'Application'; Level = 2 } -MaxEvents 50 -ErrorAction SilentlyContinue
                $ev = Get-WinEvent -FilterHashtable @{LogName = 'System'; Level = 1, 2 } -MaxEvents 16 -ErrorAction SilentlyContinue | ForEach-Object {
                    [PSCustomObject]@{ Time = $_.TimeCreated.ToString("HH:mm"); ID = $_.Id; Source = $_.ProviderName; Message = $_.Message.Trim() }
                }
                return @{
                    Success = $true;
                    HostName = $env:COMPUTERNAME;
                    IP = $net.IPv4Address[0].IPAddress;
                    CPU = $cpu.LoadPercentage;
                    RAM = [math]::Round((($comp.TotalVisibleMemorySize - $comp.FreePhysicalMemory) / $comp.TotalVisibleMemorySize * 100), 0);
                    Disk = [math]::Round((1 - ($disk.FreeSpace / $disk.Size)) * 100, 0);
                    GW = $net.IPv4DefaultGateway.NextHop; 
                    DNS = $net.DNSServer.ServerAddresses[0];
                    FW = (Get-NetFirewallProfile -Profile Domain).Enabled;
                    AV = $mp.RealTimeProtectionEnabled; 
                    Bit = ($bit.ProtectionStatus -eq "On");
                    User = $u; Logon = $l; Idle = $i; 
                    Events = $ev;
                    CritCount = ($sysLogs | Where-Object { $_.Level -eq 1 }).Count;
                    SecCount = $secLogs.Count;
                    DiskCount = $diskLogs.Count;
                    AppCount = $appLogs.Count;
                    OS = $comp.Caption;
                    Build = $comp.Version;
                    Uptime = "$($uptimeSpan.Days)d $($uptimeSpan.Hours)h $($uptimeSpan.Minutes)m";
                    BootTime = $comp.LastBootUpTime.ToString("HH:mm:ss");
                    BootDate = $comp.LastBootUpTime.ToString("MM/dd/yyyy");
                }
            }
            catch { return @{ Success = $false; Msg = $_.Exception.Message } }
        }
        if ($data.Success) {
            $lblNodeName.Text = "NODE: $($data.HostName)"
            $lblNodeIP.Text = "$($data.IP) | Latency: $($latency)ms"
            $dashCPU.Text = "$($data.CPU)%"; $pbCPU.Value = $data.CPU
            $dashRAM.Text = "$($data.RAM)%"; $pbRAM.Value = $data.RAM
            $dashDisk.Text = "$($data.Disk)%"; $pbDisk.Value = $data.Disk
            $dashPing.Text = "$($latency)ms"
            $stFW.Text = if ($data.FW) { "SECURE" } else { "OFF" }; $stFW.Foreground = if ($data.FW) { "#2ECC71" } else { "#F44336" }
            $stAV.Text = if ($data.AV) { "ACTIVE" } else { "DISABLED" }; $stAV.Foreground = if ($data.AV) { "#2ECC71" } else { "#F44336" }
            $stBit.Text = if ($data.Bit) { "ENCRYPTED" } else { "PLAIN" }; $stBit.Foreground = if ($data.Bit) { "#2ECC71" } else { "#E65100" }       
            $dashUptime.Text = $data.Uptime
            $dashBoot.Text = $data.BootTime
            $dashBootDate.Text = $data.BootDate
            $dashOS.Text = $data.OS.Replace("Microsoft ", "")
            $dashBuild.Text = "Build: $($data.Build)"        
            $stGW.Text = $data.GW; $stDNS.Text = $data.DNS
            $stUser.Text = $data.User; $stLogon.Text = "Logon: $($data.Logon)"; $stIdle.Text = "Idle: $($data.Idle)"
            if ($data.Events) { $dgEvents.ItemsSource = @($data.Events) } else { $dgEvents.ItemsSource = @() }
            $cntCritical.Text = $data.CritCount; $cntSecurity.Text = $data.SecCount; $cntDisk.Text = $data.DiskCount; $cntApp.Text = $data.AppCount
            $cntCritical.Foreground = if ([int]$data.CritCount -gt 0) { "#F44336" } else { "White" }
            $txtStatus.Text = "ONLINE"; $elStatus.Fill = "#2ECC71"; $statusDot.Fill = "#2ECC71"
            $lblGlobalHost.Text = "REMOTE HOST: $($data.HostName.ToUpper())"; $lblGlobalHost.Foreground = "White"
            $lblSubStatus.Text = "Online | User: $($data.User) | Time:$(Get-Date -Format "HH:mm:ss")"
            $mainStatus.Text = "✅ Synchronization Successful."
            $mainStatus.Foreground = [System.Windows.Media.Brushes]::LightGreen
        }
        else {
            $txtStatus.Text = "ERROR"; $elStatus.Fill = "#F44336"; $statusDot.Fill = "#F44336"
            $lblGlobalHost.Text = "REMOTE HOST: OFFLINE"; $lblGlobalHost.Foreground = "#F44336"
            $mainStatus.Text = "❌ Sync Failed: $($data.Msg)"
            $mainStatus.Foreground = [System.Windows.Media.Brushes]::Red
        }
    })

$btnEnableAllFW.Add_Click({
        Invoke-RExec { Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled True }
        $mainStatus.Text = "✅ All Windows Firewall profiles enabled."
    })

$btnDisableAllFW.Add_Click({ $confirm = [System.Windows.MessageBox]::Show("Are you sure you want to disable ALL remote firewall profiles?", "Warning", "YesNo", "Warning")
        if ($confirm -eq "Yes") {
            Invoke-RExec { Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False }
            $mainStatus.Text = "⚠️ All remote firewall profiles DISABLED."
        }
    })

$btnEnableAV.Add_Click({
        Invoke-RExec { Set-MpPreference -DisableRealtimeMonitoring $false }$mainStatus.Text = "✅ Windows Defender Real-Time Protection enabled."
    })

$btnDisableAV.Add_Click({
        Invoke-RExec { Set-MpPreference -DisableRealtimeMonitoring $true }$mainStatus.Text = "⚠️ Windows Defender Real-Time Protection disabled."
    })

$btnIsolateHost.Add_Click({ $confirm = [System.Windows.MessageBox]::Show("ISOLATE HOST: This will block all inbound/outbound network traffic except existing WinRM session. Proceed?", "Host Isolation", "YesNo", "Error")
        if ($confirm -eq "Yes") {
            Invoke-RExec {
                New-NetFirewallRule -DisplayName "Sentinel_Isolation_Outbound" -Direction Outbound -Action Block -Priority 1 -Force | Out-Null
                New-NetFirewallRule -DisplayName "Sentinel_Isolation_Inbound" -Direction Inbound -Action Block -Priority 1 -Force | Out-Null
            }
            $mainStatus.Text = "🚨 Host Network Isolation Rule Deployed."
        }
    })

$btnDisableGuest.Add_Click({
        Invoke-RExec { Disable-LocalUser -Name "Guest" -ErrorAction SilentlyContinue }
        $mainStatus.Text = "✅ Local Guest account disabled."
    })

$btnAuditAdmins.Add_Click({ $admins = Invoke-RExec { Get-LocalGroupMember -Group "Administrators" | Select-Object Name, PrincipalSource }
        $msg = "Local Administrators Group Members:`n`n"
        foreach ($a in $admins) { $msg += "• $($a.Name) ($($a.PrincipalSource))`n" }
        [System.Windows.MessageBox]::Show($msg, "Local Admin Audit", "OK", "Information")
    })

$btnPurgeSessions.Add_Click({
        Invoke-RExec {
            quser | Where-Object { $_ -match "Disc" } | ForEach-Object {
                $id = ($_ -split '\s+')[2]
                logoff $id
            }
        }
        $mainStatus.Text = "🧹 Purged all disconnected user sessions."
    })

$btnRunSecSMB.Add_Click({
        Invoke-RExec { Set-SmbServerConfiguration -EnableSMB1Protocol $false -Force }
        $mainStatus.Text = "✅ SMBv1 Protocol Disabled."
    })

$btnRunSecARP.Add_Click({
        Invoke-RExec { netsh interface ip delete arpcache }
        $mainStatus.Text = "✅ ARP Resolver Cache Deleted."
    })

$btnRunSecKlist.Add_Click({
        Invoke-RExec { klist purge }
        $mainStatus.Text = "✅ Kerberos Credential Cache Purged."
    })

$btnRunSecWinsock.Add_Click({
        Invoke-RExec { netsh winsock reset }
        $mainStatus.Text = "✅ WinSock Catalog Reset."
    })

$btnRefreshProc.Add_Click({
        $procData = Invoke-RExec {
            $allProcs = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet, Path, Responding
            $total = $allProcs.Count
            $highUsage = ($allProcs | Where-Object { $_.CPU -gt 500 -or ($_.WorkingSet / 1MB) -gt 500 }).Count
            $shells = ($allProcs | Where-Object { $_.ProcessName -match "powershell|pwsh|cmd|bash|wsl" }).Count
            $orphans = ($allProcs | Where-Object { $_.Responding -eq $false }).Count
            $gridItems = $allProcs | ForEach-Object {
                [PSCustomObject]@{
                    Id   = $_.Id
                    Name = $_.ProcessName.ToUpper()
                    CPU  = if ($_.CPU) { [math]::Round($_.CPU, 2) } else { 0 }
                    Mem  = [math]::Round($_.WorkingSet / 1MB, 2)
                    Path = $_.Path
                }
            }
            return @{
                Items   = $gridItems
                Total   = $total
                HighCPU = $highUsage
                Shells  = $shells
                Orphans = $orphans
            }
        }
        if ($procData) {
            $list = New-Object System.Collections.Generic.List[PSObject]
            foreach ($p in $procData.Items) { $list.Add($p) }
            $dgProcesses.ItemsSource = $list
            $cntTotalProc.Text = [string]$procData.Total
            $cntHighCPU.Text = [string]$procData.HighCPU
            $cntShells.Text = [string]$procData.Shells
            $cntSuspicious.Text = [string]$procData.Orphans
            if ([int]$procData.HighCPU -gt 0) {
                $cntHighCPU.Foreground = [System.Windows.Media.Brushes]::Red
            }
            else {
                $cntHighCPU.Foreground = [System.Windows.Media.Brushes]::White
            }
        }
    })

$btnKill.Add_Click({
        if ($dgProcesses.SelectedItem) { Invoke-RExec { param($id) Stop-Process -Id $id -Force } $dgProcesses.SelectedItem.Id; $btnRefreshProc.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent))) }
    })

$btnListFiles.Add_Click({
        $path = $txtFilePath.Text
        $mainStatus.Text = "Fetching file list..."
        $results = Invoke-RExec { 
            param($p) 
            Get-ChildItem -Path $p -ErrorAction SilentlyContinue | ForEach-Object { 
                [PSCustomObject]@{ 
                    Name = $_.Name
                    Type = if ($_.PSIsContainer) { "Folder" } else { "File" }
                    Size = if ($_.PSIsContainer) { "--" } else { [math]::Round($_.Length / 1MB, 2) }
                } 
            } 
        } $path
        if ($results) {
            $dgFiles.ItemsSource = $null
            $dgFiles.ItemsSource = [System.Collections.ArrayList]@($results)
            $mainStatus.Text = "Displayed $($results.Count) items."
        }
        else {
            $mainStatus.Text = "No items found or path inaccessible."
        }
    })

$btnSchedRefresh.Add_Click({
        $mainStatus.Text = "Fetching tasks..."
        $tasks = Invoke-RExec { 
            Get-ScheduledTask | ForEach-Object {
                $info = Get-ScheduledTaskInfo -TaskName $_.TaskName -TaskPath $_.TaskPath -ErrorAction SilentlyContinue
                [PSCustomObject]@{
                    Name       = $_.TaskName
                    Path       = $_.TaskPath
                    State      = $_.State.ToString()
                    LastResult = if ($info) { $info.LastTaskResult } else { "0" }
                    Author     = $_.Author
                }
            }
        }
        $dgTasks.ItemsSource = $tasks
        $mainStatus.Text = "Tasks Loaded."
    })

$btnCreateTask.Add_Click({
        $n = $txtSchedName.Text
        $e = $txtSchedPath.Text
        $a = $txtSchedArgs.Text
        $trigType = $cmbSchedTrigger.SelectedIndex

        Invoke-RExec {
            param($name, $exe, $tArgs, $tType) 
            $action = New-ScheduledTaskAction -Execute $exe -Argument $tArgs
            
            switch ($tType) {
                1 { $trigger = New-ScheduledTaskTrigger -AtStartup }
                2 { $trigger = New-ScheduledTaskTrigger -AtLogOn }
                3 { $trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1) }
                default { $trigger = New-ScheduledTaskTrigger -Daily -At 00:00 }
            }

            Register-ScheduledTask -Action $action -Trigger $trigger -TaskName $name -User "NT AUTHORITY\SYSTEM" -RunLevel Highest -Force
        } $n, $e, $a, $trigType
        $btnSchedRefresh.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent)))
    })

$btnSchedStart.Add_Click({
        if ($dgTasks.SelectedItem) {
            $sel = $dgTasks.SelectedItem
            Invoke-RExec { param($name, $path) Start-ScheduledTask -TaskName $name -TaskPath $path } $sel.Name, $sel.Path
            $mainStatus.Text = "Task Started: $($sel.Name)"
        }
    })

$btnSchedStop.Add_Click({
        if ($dgTasks.SelectedItem) {
            $sel = $dgTasks.SelectedItem
            Invoke-RExec { param($name, $path) Stop-ScheduledTask -TaskName $name -TaskPath $path } $sel.Name, $sel.Path
            $mainStatus.Text = "Task Stopped: $($sel.Name)"
        }
    })

$btnSchedEnable.Add_Click({
        if ($dgTasks.SelectedItem) {
            Invoke-RExec { param($n, $p) Enable-ScheduledTask -TaskName $n -TaskPath $p } $dgTasks.SelectedItem.Name, $dgTasks.SelectedItem.Path
            $btnSchedRefresh.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent)))
        }
    })

$btnSchedDisable.Add_Click({
        if ($dgTasks.SelectedItem) {
            $sel = $dgTasks.SelectedItem
            $mainStatus.Text = "Disabling task: $($sel.Name)..."
            Invoke-RExec { 
                param($name, $path) 
                Disable-ScheduledTask -TaskName $name -TaskPath $path -ErrorAction Stop
            } $sel.Name, $sel.Path
            $mainStatus.Text = "Task Disabled: $($sel.Name)"
            $btnSchedRefresh.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent)))
        }
        else {
            $mainStatus.Text = "Warning: No task selected to disable."
        }
    })

$btnSchedDelete.Add_Click({
        if ($dgTasks.SelectedItem) {
            $sel = $dgTasks.SelectedItem
            $confirm = [System.Windows.MessageBox]::Show("Are you sure you want to delete task: $($sel.Name)?", "Confirm", "YesNo", "Warning")
            if ($confirm -eq "Yes") {
                Invoke-RExec { param($name, $path) Unregister-ScheduledTask -TaskName $name -TaskPath $path -Confirm:$false } $sel.Name, $sel.Path
                $btnSchedRefresh.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent)))
            }
        }
    })

$txtPresetFilter.Add_TextChanged({
        $filter = $txtPresetFilter.Text.ToLower()
        foreach ($child in $pnlPresetList.Children) {
            if ($child.Tag) {
                if ([string]::IsNullOrWhiteSpace($filter) -or $child.Tag.ToString().ToLower().Contains($filter)) {
                    $child.Visibility = [System.Windows.Visibility]::Visible
                }
                else {
                    $child.Visibility = [System.Windows.Visibility]::Collapsed
                }
            }
        }
    })

$btnPresetShutdown.Add_Click({
        $txtSchedName.Text = "NightlyShutdown"
        $txtSchedPath.Text = "shutdown.exe"
        $txtSchedArgs.Text = "/s /f /t 60"
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: Nightly Shutdown"
    })

$btnPresetReboot.Add_Click({
        $txtSchedName.Text = "WeeklyReboot"
        $txtSchedPath.Text = "shutdown.exe"
        $txtSchedArgs.Text = "/r /f /t 30"
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: Weekly Reboot"
    })

$btnPresetCleanTemp.Add_Click({
        $txtSchedName.Text = "CleanTempFiles"
        $txtSchedPath.Text = "powershell.exe"
        $txtSchedArgs.Text = '-NoProfile -WindowStyle Hidden -Command "Get-ChildItem -Path $env:TEMP -Recurse -File | Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -ErrorAction SilentlyContinue"'
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: Clean Temp Files"
    })

$btnPresetBackupReg.Add_Click({
        $txtSchedName.Text = "BackupRegistry"
        $txtSchedPath.Text = "reg.exe"
        $txtSchedArgs.Text = 'export HKLM\SOFTWARE C:\Backups\SoftwareRegBackup.reg /y'
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: Backup Registry"
    })

$btnPresetLogBoot.Add_Click({
        $txtSchedName.Text = "LogStartupTime"
        $txtSchedPath.Text = "powershell.exe"
        $txtSchedArgs.Text = '-NoProfile -Command "Add-Content -Path C:\Logs\BootHistory.log -Value (Get-Date).ToString()"'
        $cmbSchedTrigger.SelectedIndex = 1
        $mainStatus.Text = "Loaded Preset: Log Startup Time"
    })

$btnPresetFlushDNS.Add_Click({
        $txtSchedName.Text = "DailyFlushDNS"
        $txtSchedPath.Text = "ipconfig.exe"
        $txtSchedArgs.Text = "/flushdns"
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: Flush DNS"
    })

$btnPresetDefScan.Add_Click({
        $txtSchedName.Text = "DefenderQuickScan"
        $txtSchedPath.Text = "C:\Program Files\Windows Defender\MpCmdRun.exe"
        $txtSchedArgs.Text = "-Scan -ScanType 1"
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: Defender Quick Scan"
    })

$btnPresetEnforceFW.Add_Click({
        $txtSchedName.Text = "EnforceFirewall"
        $txtSchedPath.Text = "netsh.exe"
        $txtSchedArgs.Text = "advfirewall set allprofiles state on"
        $cmbSchedTrigger.SelectedIndex = 3
        $mainStatus.Text = "Loaded Preset: Firewall Enforcement"
    })

$btnPresetDefrag.Add_Click({
        $txtSchedName.Text = "OptimizeDriveC"
        $txtSchedPath.Text = "defrag.exe"
        $txtSchedArgs.Text = "C: /O"
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: Optimize Drive C:"
    })

$btnPresetKillHung.Add_Click({
        $txtSchedName.Text = "AutoKillHungProcs"
        $txtSchedPath.Text = "taskkill.exe"
        $txtSchedArgs.Text = '/F /FI "STATUS eq NOT RESPONDING"'
        $cmbSchedTrigger.SelectedIndex = 3
        $mainStatus.Text = "Loaded Preset: Auto-Kill Frozen Procs"
    })

$btnPresetLogonInit.Add_Click({
        $txtSchedName.Text = "UserSessionInit"
        $txtSchedPath.Text = "powershell.exe"
        $txtSchedArgs.Text = '-NoProfile -WindowStyle Hidden -File "C:\Scripts\UserInit.ps1"'
        $cmbSchedTrigger.SelectedIndex = 2
        $mainStatus.Text = "Loaded Preset: User Logon Init"
    })

$btnPresetSysReport.Add_Click({
        $txtSchedName.Text = "SysHealthTelemetry"
        $txtSchedPath.Text = "powershell.exe"
        $txtSchedArgs.Text = '-NoProfile -Command "Get-ComputerInfo | Export-Clixml -Path C:\Logs\HealthReport.xml"'
        $cmbSchedTrigger.SelectedIndex = 0
        $mainStatus.Text = "Loaded Preset: System Health Report"
    })

function Set-ClipText ($text) {
    [System.Windows.Forms.Clipboard]::SetText($text)
    $mainStatus.Text = "📋 Command copied to clipboard!"
}

$btnCopyPreset1.Add_Click({ Set-ClipText "Register-ScheduledTask -TaskName 'NightlyShutdown' -Trigger (New-ScheduledTaskTrigger -Daily -At 00:00) -Action (New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '/s /f /t 60') -User 'NT AUTHORITY\SYSTEM' -RunLevel Highest -Force" })
$btnCopyPreset2.Add_Click({ Set-ClipText "Register-ScheduledTask -TaskName 'WeeklyReboot' -Trigger (New-ScheduledTaskTrigger -Weekly -DaysOfWeek Sunday -At 03:00) -Action (New-ScheduledTaskAction -Execute 'shutdown.exe' -Argument '/r /f /t 30') -User 'NT AUTHORITY\SYSTEM' -RunLevel Highest -Force" })
$btnCopyPreset3.Add_Click({ Set-ClipText 'Register-ScheduledTask -TaskName "CleanTempFiles" -Trigger (New-ScheduledTaskTrigger -Daily -At 02:00) -Action (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -Command `\"Get-ChildItem -Path `$env:TEMP -Recurse -File | Where-Object { `$_.LastWriteTime -lt (Get-Date).AddDays(-7) } | Remove-Item -Force -ErrorAction SilentlyContinue`\"") -User "NT AUTHORITY\SYSTEM" -RunLevel Highest -Force' })
$btnCopyPreset4.Add_Click({ Set-ClipText "Register-ScheduledTask -TaskName 'BackupRegistry' -Trigger (New-ScheduledTaskTrigger -Daily -At 01:00) -Action (New-ScheduledTaskAction -Execute 'reg.exe' -Argument 'export HKLM\SOFTWARE C:\Backups\SoftwareRegBackup.reg /y') -User 'NT AUTHORITY\SYSTEM' -RunLevel Highest -Force" })
$btnCopyPreset5.Add_Click({ Set-ClipText 'Register-ScheduledTask -TaskName "LogStartupTime" -Trigger (New-ScheduledTaskTrigger -AtStartup) -Action (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command `\"Add-Content -Path C:\Logs\BootHistory.log -Value (Get-Date).ToString()`\"") -User "NT AUTHORITY\SYSTEM" -RunLevel Highest -Force' })
$btnCopyPreset6.Add_Click({ Set-ClipText "Register-ScheduledTask -TaskName 'DailyFlushDNS' -Trigger (New-ScheduledTaskTrigger -Daily -At 06:00) -Action (New-ScheduledTaskAction -Execute 'ipconfig.exe' -Argument '/flushdns') -User 'NT AUTHORITY\SYSTEM' -RunLevel Highest -Force" })
$btnCopyPreset7.Add_Click({ Set-ClipText "Register-ScheduledTask -TaskName 'DefenderQuickScan' -Trigger (New-ScheduledTaskTrigger -Daily -At 12:00) -Action (New-ScheduledTaskAction -Execute 'C:\Program Files\Windows Defender\MpCmdRun.exe' -Argument '-Scan -ScanType 1') -User 'NT AUTHORITY\SYSTEM' -RunLevel Highest -Force" })
$btnCopyPreset8.Add_Click({ Set-ClipText "Register-ScheduledTask -TaskName 'EnforceFirewall' -Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 1)) -Action (New-ScheduledTaskAction -Execute 'netsh.exe' -Argument 'advfirewall set allprofiles state on') -User 'NT AUTHORITY\SYSTEM' -RunLevel Highest -Force" })
$btnCopyPreset9.Add_Click({ Set-ClipText "Register-ScheduledTask -TaskName 'OptimizeDriveC' -Trigger (New-ScheduledTaskTrigger -Weekly -DaysOfWeek Saturday -At 02:00) -Action (New-ScheduledTaskAction -Execute 'defrag.exe' -Argument 'C: /O') -User 'NT AUTHORITY\SYSTEM' -RunLevel Highest -Force" })
$btnCopyPreset10.Add_Click({ Set-ClipText 'Register-ScheduledTask -TaskName "AutoKillHungProcs" -Trigger (New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Hours 2)) -Action (New-ScheduledTaskAction -Execute "taskkill.exe" -Argument "/F /FI `"STATUS eq NOT RESPONDING`"") -User "NT AUTHORITY\SYSTEM" -RunLevel Highest -Force' })
$btnCopyPreset11.Add_Click({ Set-ClipText 'Register-ScheduledTask -TaskName "UserSessionInit" -Trigger (New-ScheduledTaskTrigger -AtLogOn) -Action (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -WindowStyle Hidden -File `"C:\Scripts\UserInit.ps1`"") -RunLevel Highest -Force' })
$btnCopyPreset12.Add_Click({ Set-ClipText 'Register-ScheduledTask -TaskName "SysHealthTelemetry" -Trigger (New-ScheduledTaskTrigger -Weekly -DaysOfWeek Monday -At 07:00) -Action (New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -Command `\"Get-ComputerInfo | Export-Clixml -Path C:\Logs\HealthReport.xml`\"") -User "NT AUTHORITY\SYSTEM" -RunLevel Highest -Force' })

$txtEventFilter.Add_TextChanged({
        $view = [System.Windows.Data.CollectionViewSource]::GetDefaultView($dgEvents.ItemsSource)
        if ($view) {
            $searchTerm = $txtEventFilter.Text.ToLower()
            $view.Filter = [Predicate[Object]] {
                param($item)
                if ([string]::IsNullOrWhiteSpace($searchTerm)) { return $true }
                return ($item.Message -like "*$searchTerm*") -or 
                ($item.Source -like "*$searchTerm*") -or 
                ($item.ID.ToString() -like "*$searchTerm*")
            }
            $view.Refresh()
        }
    })

$txtProcFilter.Add_TextChanged({
        $view = [System.Windows.Data.CollectionViewSource]::GetDefaultView($dgProcesses.ItemsSource)
        if ($view) {
            $searchTerm = $txtProcFilter.Text.ToLower()
            $view.Filter = [Predicate[Object]] {
                param($item)
                if ([string]::IsNullOrWhiteSpace($searchTerm)) { return $true }
                return ($item.Name -like "*$searchTerm*") -or ($item.Id.ToString() -eq $searchTerm)
            }
            $view.Refresh()
        }
    })

$btnNetstat.Add_Click({
        $mainStatus.Text = "Deep-scanning network stack and resolving hostnames..."
        $dgNetstat.ItemsSource = $null
        $netData = Invoke-RExec {
            $tcp = Get-NetTCPConnection -ErrorAction SilentlyContinue
            $udp = Get-NetUDPEndpoint -ErrorAction SilentlyContinue
            $procMap = Get-Process -IncludeUserName -ErrorAction SilentlyContinue | 
            Select-Object Id, ProcessName, Path, UserName
            $allConns = @($tcp) + @($udp)
            $allConns | ForEach-Object {
                $currPID = $_.OwningProcess
                $pInfo = $procMap | Where-Object { $_.Id -eq $currPID }
                $rAddr = $_.RemoteAddress
                $dnsName = "N/A"
                if ($rAddr -and $rAddr -notmatch "0.0.0.0|::|127.0.0.1") {
                    try { $dnsName = [System.Net.Dns]::GetHostEntry($rAddr).HostName } catch { $dnsName = "Unresolved" }
                }
                [PSCustomObject]@{
                    Protocol      = if ($_.GetType().Name -match "TCP") { "TCP" } else { "UDP" }
                    ProcessName   = if ($pInfo.ProcessName) { $pInfo.ProcessName.ToUpper() } else { "SYSTEM" }
                    PID           = $currPID
                    User          = $pInfo.UserName
                    LocalPort     = $_.LocalPort
                    RemoteAddress = if ($rAddr -eq "0.0.0.0" -or $rAddr -eq "::") { "LISTENING" } else { $rAddr }
                    Hostname      = $dnsName
                    State         = if ($_.State) { $_.State.ToString() } else { "ACTIVE" }
                    Path          = $pInfo.Path
                }
            } | Sort-Object State, ProcessName
        }
        if ($netData) {
            $dgNetstat.ItemsSource = $netData
            $mainStatus.Text = "Deep Audit Successful: $($netData.Count) sockets analyzed."
        }
        else {
            $mainStatus.Text = "Audit Failed. Check WinRM permissions."
        }
    })

$btnIPConfig.Add_Click({
        $txtNetOutput.Text = Invoke-RExec { ipconfig /all | Out-String }
    })

$btnRoutePrint.Add_Click({
        $txtNetOutput.Text = Invoke-RExec { route print -4 | Out-String }
    })

$btnDNSFlush.Add_Click({
        Invoke-RExec { ipconfig /flushdns }
        $txtNetOutput.Text = "DNS Resolver Cache Flushed Successfully."
    })

$btnPanicMsg.Add_Click({
        $customMessage = $txtCustomMsg.Text
        if ([string]::IsNullOrWhiteSpace($customMessage)) {
            $mainStatus.Text = "Error: Message cannot be empty."
            return
        }
        Invoke-RExec { 
            param($msg) 
            msg * "$msg" 
        } $customMessage
        $mainStatus.Text = "Message sent to all sessions."
    })

$btnBlockInput.Add_Click({
        Invoke-RExec {
            $code = '[DllImport("user32.dll")] public static extern bool BlockInput(bool fBlockIt);'
            $type = Add-Type -MemberDefinition $code -Name "Win32BlockInput" -Namespace Win32Functions -PassThru
            $type::BlockInput($true)
            Start-Sleep -Seconds 60
            $type::BlockInput($false)
        }
    })

$btnLock.Add_Click({
        Invoke-RExec {
            $sessionInfo = quser | Select-String ">"
            if ($sessionInfo) {
                $sessionID = ($sessionInfo -split '\s+')[2]
                tsdiscon $sessionID
            }
            else {
                tsdiscon 1
                tsdiscon 2
            }
        }
        $mainStatus.Text = "Lock/Disconnect signal sent."
    })

$btnLogoff.Add_Click({
        Invoke-RExec {
            $query = quser
            $session = $query | Select-String ">"
            if ($session) {
                $id = ($session -split '\s+')[2]
                logoff $id
            }
            else {
                logoff 1 
                logoff 2
            }
        }
        $mainStatus.Text = "Logoff command sent to active session."
    })

$btnBlackout.Add_Click({
        Invoke-RExec {
            Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
            Add-Type -AssemblyName System.Windows.Forms
            $form = New-Object Windows.Forms.Form
            $form.BackColor = "Black"
            $form.FormBorderStyle = "None"
            $form.WindowState = "Maximized"
            $form.TopMost = $true
            $form.Show()
            Start-Sleep -Seconds 15
            $form.Close()
        }
    })

$btnRestart.Add_Click({ Invoke-RExec { Restart-Computer -Force } })

$btnBuzzer.Add_Click({
        Invoke-RExec {
            $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -Command [console]::Beep(1000,1000)"
            $taskName = "RemoteBuzzer_$(Get-Random)"
            Register-ScheduledTask -TaskName $taskName -Action $action -Force -Settings (New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries) | Out-Null
            Start-ScheduledTask -TaskName $taskName
            Start-Sleep -Seconds 2
            Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
        }
    })

$btnDisableTools.Add_Click({
        Invoke-RExec {
            $path = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System"
            if (-not (Test-Path $path)) { New-Item $path -Force }
            Set-ItemProperty $path -Name "DisableTaskMgr" -Value 1
            Set-ItemProperty $path -Name "DisableRegistryTools" -Value 1
            $cmdPath = "HKCU:\Software\Policies\Microsoft\Windows\System"
            if (-not (Test-Path $cmdPath)) { New-Item $cmdPath -Force }
            Set-ItemProperty $cmdPath -Name "DisableCMD" -Value 1
        }
    })

$btnEnableTools.Add_Click({
        Invoke-RExec {
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableTaskMgr" -Value 0
            Set-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\System" -Name "DisableRegistryTools" -Value 0
            Set-ItemProperty "HKCU:\Software\Policies\Microsoft\Windows\System" -Name "DisableCMD" -Value 0
        }
    })

$btnRunShell.Add_Click({ $cmd = $txtCommand.Text; $txtOutput.Text = Invoke-RExec { param($c) Invoke-Expression $c 2>&1 | Out-String } $cmd })

$btnSvcRefresh.Add_Click({
        $svcs = Invoke-RExec { Get-Service | Select-Object Name, DisplayName, Status }
        $dgServices.ItemsSource = foreach ($s in $svcs) { [PSCustomObject]@{ Name = $s.Name; Display = $s.DisplayName; Status = $s.Status.ToString() } }
    })

$btnTakeScreenshot.Add_Click({
        $mainStatus.Text = "Requesting Remote GDI+ Capture..."
        $btnTakeScreenshot.IsEnabled = $false
        $remoteCapScript = {
            $path = "$env:TEMP\rs_cap.png"
            Add-Type -AssemblyName System.Windows.Forms, System.Drawing
            $screen = [System.Windows.Forms.Screen]::PrimaryScreen
            $bmp = New-Object System.Drawing.Bitmap($screen.Bounds.Width, $screen.Bounds.Height)
            $gfx = [System.Drawing.Graphics]::FromImage($bmp)
            $gfx.CopyFromScreen($screen.Bounds.X, $screen.Bounds.Y, 0, 0, $bmp.Size)
            $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)
            $gfx.Dispose()
            $bmp.Dispose()
        }
        $rawBytes = Invoke-RExec {
            param($sBlock)
            $tempFile = "$env:TEMP\cap_task.ps1"
            $sBlock.ToString() | Out-File $tempFile -Force
            $tName = "RC_Screenshot_$(Get-Random)"
            $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-WindowStyle Hidden -ExecutionPolicy Bypass -File $tempFile"
            Register-ScheduledTask -TaskName $tName -Action $action -Force | Out-Null
            Start-ScheduledTask -TaskName $tName
            $retry = 0
            while (!(Test-Path "$env:TEMP\rs_cap.png") -and $retry -lt 15) { Start-Sleep -Milliseconds 500; $retry++ }
            if (Test-Path "$env:TEMP\rs_cap.png") {
                $bytes = [System.IO.File]::ReadAllBytes("$env:TEMP\rs_cap.png")
                Remove-Item "$env:TEMP\rs_cap.png", $tempFile -Force -ErrorAction SilentlyContinue
                Unregister-ScheduledTask -TaskName $tName -Confirm:$false
                return $bytes
            }
        } $remoteCapScript
        if ($rawBytes) {
            $ms = New-Object System.IO.MemoryStream(, $rawBytes)
            $bi = New-Object System.Windows.Media.Imaging.BitmapImage
            $bi.BeginInit()
            $bi.StreamSource = $ms
            $bi.CacheOption = [System.Windows.Media.Imaging.BitmapCacheOption]::OnLoad
            $bi.EndInit()
            $bi.Freeze()
            $imgScreenshot.Source = $bi
            $mainStatus.Text = "Screenshot Received."
        }
        else {
            $mainStatus.Text = "Capture Failed: Ensure a user is logged in and active."
        }
        $btnTakeScreenshot.IsEnabled = $true
    })

$btnScanSoftware.Add_Click({
        $mainStatus.Text = "Deep-scanning Registry, Appx, and Running Processes..."
        $dgSoftware.ItemsSource = $null
        $softwareList = Invoke-RExec {
            $runningProcs = Get-Process | Select-Object -ExpandProperty Name
            $results = New-Object System.Collections.Generic.List[PSCustomObject]
            $regPaths = @(
                "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*",
                "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*"
            )
            foreach ($path in $regPaths) {
                $keys = Get-ItemProperty $path -ErrorAction SilentlyContinue
                foreach ($key in $keys) {
                    if ($key.DisplayName) {
                        $isRun = "Idle"
                        foreach ($p in $runningProcs) {
                            if ($key.DisplayName -like "*$p*") { $isRun = "ACTIVE"; break }
                        }
                        $results.Add([PSCustomObject]@{
                                Status      = $isRun
                                Name        = $key.DisplayName
                                Version     = $key.DisplayVersion
                                Publisher   = $key.Publisher
                                InstallDate = $key.InstallDate
                                Arch        = if ($key.PSPath -match "WOW6432Node") { "x86" } else { "x64" }
                                Source      = "Win32"
                                Location    = $key.InstallLocation
                                UninstallID = $key.PSChildName
                            })
                    }
                }
            }
            Get-AppxPackage -AllUsers | ForEach-Object {
                $results.Add([PSCustomObject]@{
                        Status      = "Modern"
                        Name        = $_.Name
                        Version     = $_.Version
                        Publisher   = ($_.Publisher -split ",")[0].Replace("CN=", "")
                        InstallDate = "N/A"
                        Arch        = "Appx"
                        Source      = "Store"
                        Location    = $_.InstallLocation
                        UninstallID = $_.PackageFullName
                    })
            }
            $results | Sort-Object Status, Name
        }
        $dgSoftware.ItemsSource = $softwareList
        $mainStatus.Text = "Inventory complete."
    })

$btnListUpdates.Add_Click({
        $mainStatus.Text = "📡 Connecting to Windows Update Agent... (This may take 30-60s)"
        $dgSoftware.ItemsSource = $null
        $updatesList = Invoke-RExec {
            try {
                $updateSession = New-Object -ComObject Microsoft.Update.Session
                $updateSearcher = $updateSession.CreateUpdateSearcher()
                $searchResult = $updateSearcher.Search("IsInstalled=0 and Type='Software'")
                $searchResult.Updates | ForEach-Object {
                    [PSCustomObject]@{
                        Status      = "PENDING"
                        Name        = $_.Title
                        Version     = "KB" + ($_.KBArticleIDs -join ", ")
                        Publisher   = "Microsoft (Windows Update)"
                        Arch        = if ($_.Categories.Name -contains "Critical Updates") { "CRITICAL" } else { "Optional" }
                        Source      = "WinUpdate"
                        InstallDate = "Waiting..."
                        UninstallID = $_.Identity.UpdateID
                    }
                }
            }
            catch {
                return $null
            }
        }
        if ($updatesList) {
            $dgSoftware.ItemsSource = $updatesList
            $mainStatus.Text = "Update Scan Complete: $($updatesList.Count) updates pending."
        }
        else {
            $mainStatus.Text = "No pending updates found or Service is disabled."
            $dgSoftware.ItemsSource = @() 
        }
    })

$btnGetFeatures.Add_Click({
        $mainStatus.Text = "Querying Windows Optional Features manifest..."
        $dgSoftware.ItemsSource = $null
        $featuresList = Invoke-RExec {
            Get-WindowsOptionalFeature -Online -ErrorAction SilentlyContinue | ForEach-Object {
                [PSCustomObject]@{
                    Status      = if ($_.State -eq "Enabled") { "ACTIVE" } else { "Disabled" }
                    Name        = $_.FeatureName
                    Version     = "OS Native"
                    Publisher   = "Microsoft Corporation"
                    Arch        = "System"
                    Source      = "WinFeature"
                    InstallDate = "N/A"
                    UninstallID = $_.FeatureName 
                }
            } | Sort-Object Status, Name
        }
        if ($featuresList) {
            $dgSoftware.ItemsSource = $featuresList
            $mainStatus.Text = "Windows Features Audit Complete: Found $($featuresList.Count) items."
        }
        else {
            $mainStatus.Text = "Error: Could not retrieve Windows Features. Try running as Admin."
        }
    })

$btnUninstallApp.Add_Click({
        $selected = $dgSoftware.SelectedItem
        if ($null -eq $selected) { 
            $mainStatus.Text = "⚠️ Error: No software selected for removal."
            $mainStatus.Foreground = "Red"
            return 
        }
        $appName = $selected.Name
        $appId = $selected.UninstallID
        $source = $selected.Source
        $msgText = "Are you absolutely sure you want to uninstall:`n`n[$appName]`n`nFrom the remote system? This action cannot be undone."
        $msgCaption = "Confirm Remote Uninstallation"
        $msgButtons = [System.Windows.MessageBoxButton]::YesNo
        $msgIcon = [System.Windows.MessageBoxImage]::Warning
        $response = [System.Windows.MessageBox]::Show($msgText, $msgCaption, $msgButtons, $msgIcon)
        if ($response -ne "Yes") {
            $mainStatus.Text = "❌ Uninstallation of $appName cancelled by user."
            $mainStatus.Foreground = "White"
            return
        }
        $mainStatus.Text = "⏳ Initializing deep-removal for: $appName..."
        $mainStatus.Foreground = "Orange"
        $result = Invoke-RExec {
            param($id, $type, $name)
            try {
                if ($type -match "Win32|Registry") {
                    $running = Get-Process | Where-Object { $_.ProcessName -match ($name -split " ")[0] } -ErrorAction SilentlyContinue
                    if ($running) {
                        Stop-Process -Name $running.ProcessName -Force -ErrorAction SilentlyContinue 
                    }
                }
                if ($type -match "Appx|Store") {
                    Remove-AppxPackage -Package $id -AllUsers -ErrorAction Stop
                    return "SUCCESS: Modern App '$name' purged."
                } 
                elseif ($type -eq "WinFeature") {
                    Disable-WindowsOptionalFeature -Online -FeatureName $id -NoRestart -ErrorAction Stop
                    return "SUCCESS: Feature '$id' disabled."
                }
                else {
                    $regPaths = @(
                        "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$id",
                        "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$id",
                        "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$id"
                    )
                    $unString = ""
                    foreach ($path in $regPaths) {
                        $key = Get-ItemProperty $path -ErrorAction SilentlyContinue
                        if ($key.UninstallString) { $unString = $key.UninstallString; break }
                    }
                    if ($unString) {
                        if ($unString -match "MsiExec.exe") {
                            $silentArgs = $unString -replace "MsiExec.exe", "" -replace "/I", "/X"
                            $silentArgs += " /qn /norestart /L*V C:\Windows\Temp\Uninstall_$id.log"
                            $p = Start-Process MsiExec.exe -ArgumentList $silentArgs -Wait -PassThru
                            if ($p.ExitCode -eq 0) { return "SUCCESS: MSI Uninstalled." }
                            else { return "FAILED: MsiExec Exit Code $($p.ExitCode)" }
                        }
                        else {
                            $p = Start-Process cmd.exe -ArgumentList "/c $unString /S /SILENT /VERYSILENT /QUIET /NORESTART" -Wait -PassThru -WindowStyle Hidden
                            return "SUCCESS: Executed Uninstaller (Exit: $($p.ExitCode))."
                        }
                    }
                    return "ERROR: Registry string for $id is missing or malformed."
                }
            }
            catch {
                return "FAILED: $($_.Exception.Message)"
            }
        } $appId $source $appName
        if ($result -match "SUCCESS") {
            $mainStatus.Text = "✅ $result ($appName)"
            $mainStatus.Foreground = "LightGreen"
            $timer = New-Object System.Windows.Threading.DispatcherTimer
            $timer.Interval = [TimeSpan]::FromSeconds(2)
            $timer.Add_Tick({
                    $this.Stop() 
                    $peer = New-Object System.Windows.Automation.Peers.ButtonAutomationPeer($btnScanSoftware)
                    $invoker = $peer.GetPattern([System.Windows.Automation.Peers.PatternInterface]::Invoke)
                    $invoker.Invoke()
                    $mainStatus.Text = "Inventory refreshed."
                })
            $timer.Start()
        }
        else {
            $mainStatus.Text = "❌ $result"
            $mainStatus.Foreground = "Red"
        }
    })

$btnScanDrivers.Add_Click({
        $target = $txtHost.Text
        if ([string]::IsNullOrWhiteSpace($target)) { 
            $mainStatus.Text = "❌ Error: No target host specified."
            $mainStatus.Foreground = "Red"
            return 
        }
        $mainStatus.Text = "📡 Step 1/1: Fetching full hardware tree from $target..."
        $mainStatus.Foreground = "Orange"
        [System.Windows.Forms.Application]::DoEvents()
        $results = Invoke-RExec {
            try {
                $allDevices = Get-PnpDevice -ErrorAction SilentlyContinue 
                $list = foreach ($dev in $allDevices) {
                    $verProperty = $dev | Get-PnpDeviceProperty -KeyName "DEVPKEY_Device_DriverVersion" -ErrorAction SilentlyContinue
                    [PSCustomObject]@{
                        Class         = $dev.Class
                        FriendlyName  = if ($dev.FriendlyName) { $dev.FriendlyName } else { $dev.Name }
                        Manufacturer  = $dev.Manufacturer
                        Status        = $dev.Status
                        DriverVersion = if ($verProperty.Data) { $verProperty.Data } else { "---" }
                        InstanceId    = $dev.InstanceId
                    }
                }
                return $list | Sort-Object Class, FriendlyName
            }
            catch {
                return $null
            }
        }
        if ($null -ne $results) {
            $global:FullDriverList = $results
            $dgDrivers.ItemsSource = @($results)
            $mainStatus.Text = "✅ Success: $($results.Count) devices indexed from $target."
            $mainStatus.Foreground = "LightGreen"
        }
        else {
            $mainStatus.Text = "❌ Failed: Could not retrieve device list (Check WinRM/Permissions)."
            $mainStatus.Foreground = "Red"
            $dgDrivers.ItemsSource = @()
        }
    })

$btnDriverProps.Add_Click({
        $selected = $dgDrivers.SelectedItem
        if (-not $selected) { return }
        $mainStatus.Text = "📡 Fetching deep properties..."
        [System.Windows.Forms.Application]::DoEvents()
        $details = Invoke-RExec {
            param($id)
            $dev = Get-PnpDevice -InstanceId $id
            $ver = ($dev | Get-PnpDeviceProperty -KeyName "DEVPKEY_Device_DriverVersion").Data
            $date = ($dev | Get-PnpDeviceProperty -KeyName "DEVPKEY_Device_DriverDate").Data
            $inf = ($dev | Get-PnpDeviceProperty -KeyName "DEVPKEY_Device_DriverInfPath").Data
            $prov = ($dev | Get-PnpDeviceProperty -KeyName "DEVPKEY_Device_DriverProvider").Data
            return "Device: $($dev.FriendlyName)`n`nStatus: $($dev.Status)`nManufacturer: $($dev.Manufacturer)`nDriver Version: $ver`nDriver Date: $date`nINF Path: $inf`nProvider: $prov`nInstance ID: $id"
        } $selected.InstanceId
        [System.Windows.MessageBox]::Show($details, "Driver Technical Properties", "OK", "Information")
    })

$btnRestartDevice.Add_Click({
        $selected = $dgDrivers.SelectedItem
        if (-not $selected) { return }
        $mainStatus.Text = "🔄 Attempting to cycle device: $($selected.FriendlyName)"
        [System.Windows.Forms.Application]::DoEvents()
        $res = Invoke-RExec {
            param($id)
            try {
                Disable-PnpDevice -InstanceId $id -Confirm:$false
                Start-Sleep -Seconds 2
                Enable-PnpDevice -InstanceId $id -Confirm:$false
                return "SUCCESS"
            }
            catch { return $_.Exception.Message }
        } $selected.InstanceId
        if ($res -eq "SUCCESS") {
            $mainStatus.Text = "✅ Device restarted successfully."
            $mainStatus.Foreground = "LightGreen"
        }
        else {
            $mainStatus.Text = "❌ Restart Failed: $res"
            $mainStatus.Foreground = "Red"
        }
    })

$btnUninstallDriver.Add_Click({
        $selected = $dgDrivers.SelectedItem
        if (-not $selected) { return }
        $msg = "Confirm uninstallation of:`n$($selected.FriendlyName)"
        $ans = [System.Windows.MessageBox]::Show($msg, "Warning", "YesNo", "Exclamation")
        if ($ans -eq "Yes") {
            $id = $selected.InstanceId
            $res = Invoke-RExec {
                param($targetId)$process = Start-Process pnputil -ArgumentList "/remove-device ""$targetId""" -Wait -PassThru -WindowStyle Hidden
                if ($process.ExitCode -eq 0) { return "OK" } else { return "Error Code: $($process.ExitCode)" }
            } $id
            if ($res -eq "OK") {
                $mainStatus.Text = "✅ Device Removed. Refreshing..."
                $btnScanDrivers.RaiseEvent((New-Object System.Windows.RoutedEventArgs([System.Windows.Controls.Button]::ClickEvent)))
            }
            else {
                $mainStatus.Text = "❌ Failed: $res"
            }
        }
    })

$txtDriverFilter.Add_TextChanged({
        if ($global:FullDriverList) {
            $q = $txtDriverFilter.Text
            $dgDrivers.ItemsSource = @($global:FullDriverList | Where-Object { $_.FriendlyName -match $q -or $_.Class -match $q })
        }
    })

$window.ShowDialog() | Out-Null