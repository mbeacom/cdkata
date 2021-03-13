"""Define tests relevant to the CDKata CLI."""
from __future__ import annotations

import fire

from .. import __version__
from ..cli import CDKata, main


def test_cdkata_init():
    """Test CDKata initialization."""
    cdkata_obj: CDKata = CDKata(test="test")
    assert cdkata_obj


def test_cdkata_repr():
    """Test the CDKata.repr method."""
    cdkata_obj: CDKata = CDKata()
    assert "CDKata" in str(cdkata_obj)


def test_cdkata_version():
    """Test the CDKata.version method."""
    cdkata_obj: CDKata = CDKata()
    assert cdkata_obj.version == __version__


def test_cli_version(capsys):
    """Test the CLI derived version result."""
    fire.Fire(CDKata, ["version"])
    captured = capsys.readouterr()
    result = captured.out
    assert __version__ in result


def test_main():
    """Test the cli.main method."""
    main_obj = main()
    assert main_obj is None
