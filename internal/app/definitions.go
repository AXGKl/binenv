package app

import (
	"github.com/axgkl/binenv/internal/fetch"
	"github.com/axgkl/binenv/internal/install"
	"github.com/axgkl/binenv/internal/list"
	"github.com/axgkl/binenv/internal/mapping"
	"github.com/axgkl/binenv/internal/platform"
)

// Distributions holds the list of available software sources
type Distributions struct {
	Sources map[string]Sources `yaml:"sources"`
}

// Sources contains a software source definition
type Sources struct {
	// Name    string  `yaml:"name"`
	Description        string              `yaml:"description"`
	URL                string              `yaml:"url"`
	Map                mapping.Remapper    `yaml:"map"`
	List               list.List           `yaml:"list"`
	Fetch              fetch.Fetch         `yaml:"fetch"`
	Install            install.Install     `yaml:"install"`
	PostInstallMessage string              `yaml:"post_install_message"`
	SupportedPlatforms []platform.Platform `yaml:"supported_platforms"`
}
