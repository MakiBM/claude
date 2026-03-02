.PHONY: claude key kill

claude: ## Start Claude CLI YOLO with MCP config
	@claude --dangerously-skip-permissions --mcp-config .claude/.mcp.json --model claude-opus-4-5-20251101

key: ## Generate random 32-byte hex key
	@node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"

kill: ## Kill process on port: make kill 3000 (skips Docker processes)
	@port=$(filter-out $@,$(MAKECMDGOALS)); \
	if [ -z "$$port" ]; then echo "Usage: make kill <port>"; exit 1; fi; \
	pid=$$(lsof -ti:$$port 2>/dev/null | while read p; do \
		cmd=$$(ps -p $$p -o comm= 2>/dev/null); \
		echo "$$cmd" | grep -qiE '(com\.docker|docker|vpnkit)' || echo $$p; \
	done | head -1); \
	if [ -z "$$pid" ]; then echo "No process on port $$port"; else kill -9 $$pid && echo "Killed $$pid on port $$port"; fi

%:
	@:
