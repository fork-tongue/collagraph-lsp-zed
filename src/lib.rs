use zed_extension_api::{self as zed, Result, LanguageServerId, Worktree};
use std::fs;

struct CollagraphExtension {
    cached_binary_path: Option<String>,
}

impl CollagraphExtension {
    fn language_server_binary_path(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<String> {
        if let Some(path) = &self.cached_binary_path {
            if fs::metadata(path).map_or(false, |stat| stat.is_file()) {
                return Ok(path.clone());
            }
        }

        // Try to find collagraph-lsp in the worktree's PATH
        if let Some(path) = worktree.which("collagraph-lsp") {
            self.cached_binary_path = Some(path.clone());
            return Ok(path);
        }

        // Check if uv is available - if so, we'll use it to run collagraph-lsp
        if let Some(uv_path) = worktree.which("uv") {
            self.cached_binary_path = Some(uv_path.clone());
            return Ok(uv_path);
        }

        Err(
            "collagraph-lsp not found. Please install it using: uv pip install collagraph-lsp"
                .to_string(),
        )
    }
}

impl zed::Extension for CollagraphExtension {
    fn new() -> Self {
        Self {
            cached_binary_path: None,
        }
    }

    fn language_server_command(
        &mut self,
        language_server_id: &LanguageServerId,
        worktree: &zed::Worktree,
    ) -> Result<zed::Command> {
        let binary_path = self.language_server_binary_path(language_server_id, worktree)?;

        // Determine if we're using uv or direct collagraph-lsp
        let (command, args) = if binary_path.ends_with("uv") {
            // Use uv to run collagraph-lsp
            (binary_path, vec!["run".to_string(), "collagraph-lsp".to_string()])
        } else {
            // Use collagraph-lsp directly
            (binary_path, vec![])
        };

        Ok(zed::Command {
            command,
            args,
            env: Default::default(),
        })
    }
}

zed::register_extension!(CollagraphExtension);
