require 'resolv'
require 'open3'
require 'json'
require 'net/http'
require 'uri'

def print_line_with_delay(line, delay = 0.02)
  line.each_char do |char|
    print char
    $stdout.flush  
    sleep(delay)
  end
  puts
end

def display_colored_banner
  banner_lines = [
    "\e[1;33m███████╗ █████╗ ███████╗████████╗    ████████╗██╗███╗   ███╗ ██████╗ ██████╗      ██████╗ ██╗  ██╗ ██████╗ ███████╗████████╗███████╗███████╗ \e[0m",
    "\e[1;33m██╔════╝██╔══██╗██╔════╝╚══██╔══╝    ╚══██╔══╝██║████╗ ████║██╔═══██╗██╔══██╗    ██╔════╝ ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝██╔════╝██╔════╝ \e[0m",
    "\e[1;37m███████╗███████║███████╗   ██║          ██║   ██║██╔████╔██║██║   ██║██████╔╝    ██║  ███╗███████║██║   ██║███████╗   ██║   ███████╗█████╗  \e[0m",
    "\e[1;37m██╔══╝  ██╔══██║╚════██║   ██║          ██║   ██║██║╚██╔╝██║██║   ██║██╔══██╗    ██║   ██║██╔══██║██║   ██║╚════██║   ██║   ╚════██║██╔══╝  \e[0m",
    "\e[1;31m███████╗██║  ██║███████║   ██║          ██║   ██║██║ ╚═╝ ██║╚██████╔╝██║  ██║    ╚██████╔╝██║  ██║╚██████╔╝███████║   ██║   ███████║███████╗ \e[0m",
    "\e[1;31m╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝          ╚═╝   ╚═╝╚═╝     ╚═╝ ╚═════╝ ╚═╝  ╚═╝     ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚══════╝ \e[0m"
  ]

  banner_lines.each { |line| print_line_with_delay(line) }
  print_line_with_delay("\e[1;37m                                       EAST TIMOR GHOST SECURITY (Mr.Y) version: 1.0\e[0m\n")
end

def resolve_with_resolv(domain)
  results = { domain: domain, records: {} }

  puts "Performing DNS resolution using Resolv for: #{domain}"
  resolver = Resolv::DNS.new

  begin
    results[:records][:A] = resolver.getresources(domain, Resolv::DNS::Resource::IN::A).map(&:address)
  rescue Resolv::ResolvError
    results[:records][:A] = []
  end

  begin
    results[:records][:AAAA] = resolver.getresources(domain, Resolv::DNS::Resource::IN::AAAA).map(&:address)
  rescue Resolv::ResolvError
    results[:records][:AAAA] = []
  end

  begin
    cname = resolver.getresource(domain, Resolv::DNS::Resource::IN::CNAME)
    results[:records][:CNAME] = cname.name.to_s if cname
  rescue Resolv::ResolvError
    results[:records][:CNAME] = nil
  end

  begin
    results[:records][:MX] = resolver.getresources(domain, Resolv::DNS::Resource::IN::MX).map { |mx| { exchange: mx.exchange.to_s, priority: mx.preference } }
  rescue Resolv::ResolvError
    results[:records][:MX] = []
  end

  begin
    results[:records][:NS] = resolver.getresources(domain, Resolv::DNS::Resource::IN::NS).map(&:name)
  rescue Resolv::ResolvError
    results[:records][:NS] = []
  end

  begin
    results[:records][:TXT] = resolver.getresources(domain, Resolv::DNS::Resource::IN::TXT).map(&:strings).flatten
  rescue Resolv::ResolvError
    results[:records][:TXT] = []
  end

  results
end

def resolve_with_dig(domain)
  puts "Performing DNS resolution using dig for: #{domain}"
  stdout, stderr, status = Open3.capture3("dig #{domain} ANY")

  if status.success?
    puts stdout
  else
    puts "Error while executing dig: #{stderr}"
  end
end

def save_results_to_json(results)
  File.open("dns_results.json", "w") { |f| f.write(JSON.pretty_generate(results)) }
  puts "Results saved to dns_results.json"
end

def wait_for_ctrl_c
  puts "\nPress CTRL + C to exit..."
  begin
    sleep
  rescue Interrupt
    puts "\n"
    print_line_with_delay("THANK YOU FOR SCANNING", 0.1)
    exit
  end
end

# Display banner
display_colored_banner

# Prompt user for domain
print "Enter your domain (e.g., https://example.com): "
input = gets.chomp.strip
domain = input.sub(%r{https?://}, '')

# Perform DNS resolution
results = resolve_with_resolv(domain)
puts "\n---\n"
resolve_with_dig(domain)

# Save results
save_results_to_json(results)

# Wait for CTRL + C
wait_for_ctrl_c
